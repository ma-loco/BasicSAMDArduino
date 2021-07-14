#include <Arduino.h>

#include <Wire.h> //include Wire.h library

#include <U8g2lib.h>

#include <SPI.h>

#define OLED_I2C_ADDR 0x3C
//U8X8_SSD1306_128X64_NONAME_HW_I2C u8x8(U8X8_PIN_NONE);
U8G2_SSD1306_128X64_NONAME_1_HW_I2C u8g2(U8G2_R0); // We use the constructor "1" which has the smallest buffer.

#define EXT_MEM_CSPIN (6u)
SPISettings memSPISettings(4000000, MSBFIRST, SPI_MODE0);

#define FLASH_IMG_VSIG_MARKER_BYTE 0x99
#define FLASH_IMG_VSIG_LEN 2

static byte imgDataLine[128/8];

#define ADC_TEST_PIN A3

// Note that DAC0 is also A0
#define DAC_TEST_OUT_PIN DAC0
#define DAC_TEST_IN_PIN A1

#define PWM_TEST_OUT 2
#define PWM_TEST_IN A2

inline byte reverseBits(byte b) {
   b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
   b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
   b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
   return b;
}


void blinkLed(int numTimes);
void sendSerialTestInfo(const char* testId);
void writeScreenTestInfo(const char *testId, boolean flashDisplay);
void writeScreenError(const char* desc);
void writeScreenValue(unsigned long value, bool hexadecimal);
void writeScreenValue(const char* desc, unsigned long value, bool hexadecimal);
void writeScreenValues(unsigned long value1, unsigned long value2, bool hexadecimal);
uint16_t readFlashMemID();
uint8_t readFlashByte(uint32_t address);
void readFlashBytes(uint32_t address, byte *buf, uint16_t len);

void setup(){
  // All done in loop so that each peripheral gets initialized just before its test
}

void loop()
{
  unsigned int testNum = 1;
  bool firstStart = true;
  const char* testId;

  // Test led
  if(firstStart){
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, LOW);
  }
  blinkLed(testNum);
  testNum++;

  delayMicroseconds(1000*1000);

  // Test Serial
  testId = "UART";
  if(firstStart){
    Serial.begin(9600); // The default baudrate of Serial monitor is set to 9600 and we don't need any speed
  }
  blinkLed(testNum);
  sendSerialTestInfo(testId);
  testNum++;

  delayMicroseconds(1000*1000);

  // Test I2C
  if(firstStart){
    u8g2.begin();
    u8g2.setFont(u8g2_font_profont12_mr);
    /*
    u8x8.begin();
    u8x8.setFont(u8x8_font_chroma48medium8_r);
    */
  }
  testId = "I2C"; 
  blinkLed(testNum);
  sendSerialTestInfo(testId);
  writeScreenTestInfo(testId, true);
  testNum++;

  delayMicroseconds(1000*1000);

  // Test SPI
  if(firstStart){
    SPI.begin();
    pinMode(EXT_MEM_CSPIN, OUTPUT);
  }
  testId = "SPI";
  blinkLed(testNum);
  sendSerialTestInfo(testId);
  writeScreenTestInfo(testId, false);

  delayMicroseconds(1000*1000);

  // Get memory ID and show it on screen
  unsigned long memID = readFlashMemID();
  writeScreenValue("MemID:", memID, true);

  delayMicroseconds(4000*1000);

  // Get an image from flash and render it on screen  
  byte sigByte1 = readFlashByte(0x000000);
  if(sigByte1 != FLASH_IMG_VSIG_MARKER_BYTE){
    Serial.println("Error: Image signature not found in flash memory");
    writeScreenError("No IMG in Mem");
  } else {
    /*
     * Slowish method of showing the image from the flash memory by reading and rendering one line at a time that saves lots of RAM vs reading 
     * and rendering the whole image
     */
    uint32_t imgDataBaseAddr = FLASH_IMG_VSIG_LEN; // Image location starts after the signature bytes
    uint8_t imgLineBytes = 128 / 8;
    u8g2.firstPage();
    do {
      for(int i = 0; i < 64; i++){
        // Read img data for one line from flash
        readFlashBytes(imgDataBaseAddr + (i*imgLineBytes), imgDataLine, imgLineBytes);
        // Reverse order of bits in each byte as U82G drawXBM expects a bit order where the display leftmost bit of each byte is actually the least
        // significant bit (rightmost) in the data.
        for(int i=0; i < imgLineBytes; i++) imgDataLine[i] = reverseBits(imgDataLine[i]);
        // Draw this line of the image in the display
        u8g2.drawXBM(0, i, 128, 1, imgDataLine);
      }
    } while ( u8g2.nextPage() );
  }

  delayMicroseconds(4000*1000);
  //u8x8.clearDisplay();
  u8g2.clearDisplay();
  testNum++;

  // Test ADC
  testId = "ADC";
  blinkLed(testNum);
  sendSerialTestInfo(testId);
  writeScreenTestInfo(testId, false);

  delayMicroseconds(1000*1000);

  analogReference(AR_DEFAULT); // Ref = 1/2 VDDANA & Gain = 1/2 = max val = VDDANA
  analogReadResolution(10);
  int readVal = analogRead(ADC_TEST_PIN);
  long mappedReadVal = map(readVal, 0, 1024, 0, 330);
  writeScreenValue("Read:", mappedReadVal, false);

  delayMicroseconds(4000*1000);
  //u8x8.clearDisplay();
  u8g2.clearDisplay();
  testNum++;

  // Test DAC
  testId = "DAC";
  blinkLed(testNum);
  sendSerialTestInfo(testId);
  writeScreenTestInfo(testId, false);

  delayMicroseconds(1000*1000);

  // Note that in the SAMD Arduino Core the DAC always uses AVCC (aka VDDANA) as ref
  analogWriteResolution(10); // Use the same as ADC
  int maxVal = 0x400 - 1;
  int writeVal = 0x1A3;
  analogWrite(DAC_TEST_OUT_PIN, writeVal); // Write the write val
  long mappedWriteVal = map(writeVal, 0, maxVal, 0, 330);

  readVal = analogRead(DAC_TEST_IN_PIN); // Read the analog val outputted by the DAC
  mappedReadVal = map(readVal, 0, maxVal, 0, 330);
  writeScreenValues(mappedWriteVal, mappedReadVal, false); 

  delayMicroseconds(5000*1000);

  DAC->CTRLA.bit.ENABLE = 0x00; // DAC off
  testNum++;

  // Test PWM
  testId = "PWM";
  blinkLed(testNum);
  sendSerialTestInfo(testId);
  writeScreenTestInfo(testId, false);
  // Flush charge in filter
  pinMode(PWM_TEST_OUT, OUTPUT);
  digitalWrite(PWM_TEST_OUT, LOW);

  delayMicroseconds(1000*1000);

  pinMode(PWM_TEST_OUT, INPUT);

  int step = 0x80;
  maxVal = 0x400 - 1;
  analogWriteResolution(10); // Yes, analog write resolution affects PWM. Stupid implementation IMHO.
  writeVal = 0;
  while( writeVal <= maxVal){
    analogWrite(PWM_TEST_OUT, writeVal); 
    delayMicroseconds(500*1000); // Wait for Cap of low pass filter to do charge to average wave value
    readVal = analogRead(PWM_TEST_IN);
    mappedReadVal = map(readVal, 0, maxVal, 0, 330);
    mappedWriteVal = map(writeVal, 0, maxVal, 0, 330);
    writeScreenValues(mappedWriteVal, mappedReadVal, false); 
    delayMicroseconds(2000*1000);

    writeVal += step;
  }

  u8g2.clearDisplay();
  delayMicroseconds(5000*1000);

  firstStart = false;
}


void blinkLed(int numTimes){
  for(int i = 0; i < numTimes; i++){
    digitalWrite(LED_BUILTIN, HIGH);
    delayMicroseconds(200*1000);
    digitalWrite(LED_BUILTIN, LOW);
    delayMicroseconds(200*1000);
  }
}

void sendSerialTestInfo(const char* testId){
  Serial.print("Test ");
  Serial.println(testId);
}

void writeScreenTestInfo(const char *testId, boolean flashDisplay){
  u8g2.firstPage();
  do {
    u8g2.setCursor(32, 24);
    u8g2.print("Test ");
    u8g2.println(testId);
  } while ( u8g2.nextPage() );
  /*
  u8x8.setCursor(4, 3);
  u8x8.print("Test ");
  u8x8.print(testId);
  */

  delayMicroseconds(2000*1000);

  if(flashDisplay){
    Wire.beginTransmission(OLED_I2C_ADDR);
    Wire.write((uint8_t)0);
    Wire.write(0xA7); // Invert screen
    Wire.endTransmission();

    delayMicroseconds(2000*1000);

    //u8x8.clearDisplay();
    u8g2.clearDisplay();

    Wire.beginTransmission(OLED_I2C_ADDR);
    Wire.write((uint8_t)0);
    Wire.write(0xA6); // Non-Invert screen
    Wire.endTransmission();
  }
}

void writeScreenError(const char* desc){
  u8g2.firstPage();
  do {
    u8g2.setCursor(8, 24);
    u8g2.print("ERROR");
    if(desc != NULL){
      u8g2.println(":");
      u8g2.print(desc);
      u8g2.print(" ");
    } 
  } while ( u8g2.nextPage() );
}

void writeScreenValue(const char* desc, unsigned long value, bool hexadecimal){
  /*
  u8x8.clearDisplay();
  u8x8.setCursor(1, 3);
  u8x8.print("0x");
  u8x8.print(value, HEX);
  */
  u8g2.firstPage();
  do {
    u8g2.setCursor(8, 24);
    if(desc != NULL){
      u8g2.print(desc);
      u8g2.print(" ");
    } 
    if(hexadecimal){
      u8g2.print("0x");
      u8g2.print(value, HEX);
    } else {
      u8g2.print(value, DEC);
    }

  } while ( u8g2.nextPage() );
}

void writeScreenValue(unsigned long value, bool hexadecimal){
  writeScreenValue(NULL, value, hexadecimal);
}

void writeScreenValues(unsigned long value1, unsigned long value2, bool hexadecimal){
  u8g2.firstPage();
  do {
    u8g2.setCursor(8, 24);
    if(hexadecimal){
      u8g2.print("0x");
      u8g2.print(value1, HEX);
    } else {
      u8g2.print(value1, DEC);
    }

    u8g2.setCursor(8, 40);
    if(hexadecimal){
      u8g2.print("0x");
      u8g2.print(value2, HEX);
    } else {
      u8g2.print(value2, DEC);
    }
  } while ( u8g2.nextPage() );
}

uint16_t readFlashMemID(){
  uint16_t memID = 0;
  SPI.beginTransaction(memSPISettings);
  digitalWrite(EXT_MEM_CSPIN, LOW);
  SPI.transfer(0x9F); // Send: Read ID
  memID = SPI.transfer16(0x00); // Read: High byte = manufacturer ID; Low byte = JEDEC ID high byte;
  digitalWrite(EXT_MEM_CSPIN, HIGH);
  SPI.endTransaction();
  return memID;
}

uint8_t readFlashByte(uint32_t address){
  address &= 0x00FFFFFF; // Make sure it's 24 bit

  uint8_t dataByte = 0;
  SPI.beginTransaction(memSPISettings);
  digitalWrite(EXT_MEM_CSPIN, LOW);
  SPI.transfer(0x03); // Send: Read Data
  SPI.transfer(address >> 16); // Send: Address (note: 24 bits)
  SPI.transfer(address >> 8); 
  SPI.transfer(address); 
  dataByte = SPI.transfer(0); // Read: A single byte
  digitalWrite(EXT_MEM_CSPIN, HIGH);
  SPI.endTransaction();
  return dataByte;
}

void readFlashBytes(uint32_t address, byte *buf, uint16_t len){
  address &= 0x00FFFFFF; // Make sure it's 24 bit

  SPI.beginTransaction(memSPISettings);
  digitalWrite(EXT_MEM_CSPIN, LOW);
  SPI.transfer(0x0B); // Send: Read Data Fast
  SPI.transfer(address >> 16); // Send: Address (note: 24 bits)
  SPI.transfer(address >> 8); 
  SPI.transfer(address);
  SPI.transfer(0x00); // Send: dummy byte required by this command
  // Read: Len number of bytes
  for (uint16_t i = 0; i < len; ++i){
    ((uint8_t*) buf)[i] = SPI.transfer(0);
  }
  digitalWrite(EXT_MEM_CSPIN, HIGH);
  SPI.endTransaction();
}
