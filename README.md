# BasicSAMDArduino
This project if for a simple custom Arduino board for ATSAMD21E1xA/B/C microcontrollers. These controllers are the 32 pin version of the
ATSAMDE21G18 used in the Arduino Zero. The 32 pin package has been chosen because adaptor boards for it are easy to find and can be hand 
soldered with a soldering iron without a microscope or special soldering iron.

All that is required for this custom board is:
* The microcontroller itself, in a TQFP32 package (i.e. the -AU version). Any ATSAMD21E1xA/B/C-AU will work but the E14 one has too little memory to be usefull.
* 1 32-pin adaptor board for QFP32 chips with a 0.8mm pitch (distance between pins).
* 1 1uF SMD 0604 ceramic capacitor. This size has been chosen because it is perfect to solder between two pins of the pinheader of the board.
* 1 0.1uF SMD 0604 ceramic capacitor
* 1 0.1uF THT ceramic capacitor
* 2 10uF THT tantalum capacitors or 2 100uF THT electrolitic capacitors.
* 1 10uH THT inductor

This project is designd to support not only the 32 pin variant of the chip with 256KB of flash (i.e. the ATSAMD21E18A/B/C) but also other
variants of the same family with different memory sizes.

# What's present
At the moment Arduino variant support is present for the ATSAMD21E15B (which has 32KB flash and 4KB SRAM) and the ATSAMD21E17A (which has 128KB flash and 16KB SRAM) but adding
support for other microcontrollers of this family with the same number of pins is easy.

Please note that only support for using PlatformIO as build tool is present - the variant files will also work with the Arduino IDE but there is no build configuration for this latter IDE.

Included is a simple blink program - note that LED_BUILTIN is mapped to Arduino pin 12 which in turn is pin 25 in the adaptor board.


