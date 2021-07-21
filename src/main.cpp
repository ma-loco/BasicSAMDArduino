#include <Arduino.h>

void setup(){
  pinMode(LED_BUILTIN, OUTPUT);  
}

void loop(){
  digitalWrite(LED_BUILTIN, HIGH);
  delayMicroseconds(1000*500); // Note that delay() doesn't work correctly in this Arduino Core but delayMicros() does.
  digitalWrite(LED_BUILTIN, LOW);
  delayMicroseconds(1000*500);
}
