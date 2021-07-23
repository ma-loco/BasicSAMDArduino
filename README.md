# BasicSAMDArduino
This project is for a simple custom Arduino board for ATSAMD21E1xA/B/C microcontrollers. These controllers are the 32 pin version of the
ATSAMDE21G18 used in the Arduino Zero, which come in a range of different Flash and RAM memory capacities but are otherwise the same. The 32 pin package has been 
chosen because adaptor boards that form factor are easy to find and such microcontrollers, although SMD mounted, have pins which are still large enough that they can
be hand soldered with a soldering iron and without a microscope or a special soldering iron.

# Hardware
All that is required for making this custom board is:
* The microcontroller itself, in a TQFP32 package (i.e. the -AU version). Any ATSAMD21E1xA/B/C-AU will work but the E14 one has too little memory to be usefull.
* 1 32-pin adaptor board for QFP32 chips with a 0.8mm pitch (distance between pins).
* 2 16-pin male pin headers (which can be cut from easy to find 40-pin ones)
* 1 1uF SMD 0604 ceramic capacitor. This size has been chosen because it is perfect to solder between two pins of the pin header of the board.
* 1 0.1uF SMD 0604 ceramic capacitor
* 1 0.1uF THT ceramic capacitor
* 2 10uF THT tantalum capacitors or 2 100uF THT electrolitic capacitors.
* 1 10uH THT inductor with a minimum current capacity of 200mA.

Please check the schematic in the KiCad project under "BasicCustomBoard-Hardware" for details of what to connect to what and where. In the same subdirectory there is also a picture of one of these boards made with a ATSAMD21E17A-AU which should give you an idea of one way to organise the components (please note that if available a smaller - about 0.2A - inductor can be used as the one on the picture is designed to carry a lot more current and hence is unnecessarily large).

The components used are those listed n the Schematic Checklist of the Datasheet for this microcontroller family.

Please note that these microcontrollers operate at 3.3V so you need to supply them with that. Thus to operate from the 5V supplied by USB you have to regulate that down to 3.3V

Also note that these custom boards do not have USB (although it can be added and the Arduino variant configuration and software is ready for it) and hence programming has to be done via a programmer which supports SWD, for example a JLink programmer or a Blackmagic Probe (this latter one can be made from a bluepill board). On the upside no memory is used by a bootloader and as one requires a SWD programmer to install the bootloader, there really is little point in using usb programming with a bootloader if you already have a proper programmer. 

# Software
At the moment, inside the "variants" subdirectory there is Arduino variant support for the ATSAMD21E15B (which has 32KB flash and 4KB SRAM) and the ATSAMD21E17A (which has 128KB flash and 16KB SRAM) but adding support for other microcontrollers of this family with the same number of pins is easy.

The pins are configured so that, besides the traditional Digital I/O pins and Analog pins, one of the Analog pins is also a DAC (i.e it supports Analog Out) and there are one of each of dedicated set of pins with Hardware support for I2C (aka TwoWire), SPI, and Serial communications. Also note that the pins for a 32k crystal oscilator and USB are reserved so a custom designed board (rather than one made using an adaptor board) which has either of or both of them will work with this variant configuration.

Please note that only support for using PlatformIO as IDE and build tool is present - the variant files themselves will also work with the Arduino IDE but the build configuration for this IDE is not provided (yet).

Included is a simple blink program - note that LED_BUILTIN is mapped to Arduino pin 12 which in turn is pin 25 in the adaptor board.

# TODO
* Pin mapping diagram
* Arduino IDE configuration 


