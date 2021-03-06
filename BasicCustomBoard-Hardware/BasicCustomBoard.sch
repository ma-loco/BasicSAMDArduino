EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_SAMD:ATSAMD21E15B-A U1
U 1 1 60EB026B
P 4700 4400
F 0 "U1" H 5330 4446 50  0000 L CNN
F 1 "ATSAMD21E15B-A" H 5330 4355 50  0000 L CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 5600 2550 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/SAM_D21_DA1_Family_Data%20Sheet_DS40001882E.pdf" H 4700 4400 50  0001 C CNN
	1    4700 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 2800 4000 2800
Wire Wire Line
	2300 2900 4000 2900
Wire Wire Line
	2300 3000 4000 3000
Wire Wire Line
	2300 3100 4000 3100
Wire Wire Line
	2300 3200 4000 3200
Wire Wire Line
	2300 3300 4000 3300
Wire Wire Line
	2300 3400 4000 3400
$Comp
L Connector_Generic:Conn_01x16 J1
U 1 1 60EB9D31
P 2100 3500
F 0 "J1" H 2018 4417 50  0000 C CNN
F 1 "Left Row" H 2018 4326 50  0000 C CNN
F 2 "" H 2100 3500 50  0001 C CNN
F 3 "~" H 2100 3500 50  0001 C CNN
	1    2100 3500
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x16 J2
U 1 1 60EBCBD1
P 2100 5300
F 0 "J2" H 2018 6217 50  0000 C CNN
F 1 "Right Row" H 2018 6126 50  0000 C CNN
F 2 "" H 2100 5300 50  0001 C CNN
F 3 "~" H 2100 5300 50  0001 C CNN
	1    2100 5300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2300 3800 3700 3800
Wire Wire Line
	3700 3800 3700 3600
Wire Wire Line
	3700 3600 4000 3600
Wire Wire Line
	4000 3700 3800 3700
Wire Wire Line
	3800 3700 3800 3900
Wire Wire Line
	3800 3900 2300 3900
Wire Wire Line
	2300 4000 3900 4000
Wire Wire Line
	3900 4000 3900 3800
Wire Wire Line
	3900 3800 4000 3800
Wire Wire Line
	4000 3900 4000 4100
Wire Wire Line
	4000 4100 2300 4100
$Comp
L power:GND #PWR?
U 1 1 60EBE571
P 3750 2500
F 0 "#PWR?" H 3750 2250 50  0001 C CNN
F 1 "GND" H 3755 2327 50  0000 C CNN
F 2 "" H 3750 2500 50  0001 C CNN
F 3 "" H 3750 2500 50  0001 C CNN
	1    3750 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 60EBF162
P 4050 2400
F 0 "C1" V 3850 2250 50  0000 C CNN
F 1 "1uF" V 3950 2250 50  0000 C CNN
F 2 "" H 4088 2250 50  0001 C CNN
F 3 "~" H 4050 2400 50  0001 C CNN
	1    4050 2400
	0    1    1    0   
$EndComp
Wire Wire Line
	3750 2500 3750 2400
Wire Wire Line
	3750 2400 3900 2400
Wire Wire Line
	4200 2400 4400 2400
Wire Wire Line
	4400 2400 4400 2500
$Comp
L Device:C C3
U 1 1 60EC274C
P 4200 1650
F 0 "C3" V 4400 1800 50  0000 C CNN
F 1 "0.1uF" V 4300 1800 50  0000 C CNN
F 2 "" H 4238 1500 50  0001 C CNN
F 3 "~" H 4200 1650 50  0001 C CNN
	1    4200 1650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4050 1650 4050 1850
Wire Wire Line
	4050 1850 3750 1850
Connection ~ 4050 1850
Wire Wire Line
	4050 1850 4050 2050
Connection ~ 3750 2400
Connection ~ 4350 1850
Wire Wire Line
	4350 1850 4350 1650
Wire Wire Line
	4350 2050 4350 1850
$Comp
L power:VDD #PWR?
U 1 1 60ECA813
P 4600 900
F 0 "#PWR?" H 4600 750 50  0001 C CNN
F 1 "VDD" H 4615 1073 50  0000 C CNN
F 2 "" H 4600 900 50  0001 C CNN
F 3 "" H 4600 900 50  0001 C CNN
	1    4600 900 
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 60ED1D24
P 5400 1650
F 0 "C5" V 5600 1450 50  0000 C CNN
F 1 "0.1uF" V 5500 1450 50  0000 C CNN
F 2 "" H 5438 1500 50  0001 C CNN
F 3 "~" H 5400 1650 50  0001 C CNN
	1    5400 1650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4600 1550 4650 1550
Wire Wire Line
	5550 1850 5550 1650
Wire Wire Line
	5550 1850 5550 2050
Connection ~ 5550 1850
Wire Wire Line
	5550 1850 5850 1850
Wire Wire Line
	5250 2050 5250 1850
Wire Wire Line
	5000 1850 5250 1850
Connection ~ 5250 1850
Wire Wire Line
	5250 1850 5250 1650
Text GLabel 5500 2400 2    50   Output ~ 0
VDDANA
Text GLabel 2700 3600 2    50   Input ~ 0
VDDANA
Wire Wire Line
	2300 3600 2700 3600
Wire Wire Line
	2300 4200 4000 4200
Wire Wire Line
	2300 4300 4000 4300
Wire Wire Line
	2300 5000 4000 5000
Wire Wire Line
	4000 5100 2300 5100
Wire Wire Line
	2300 5200 4000 5200
Wire Wire Line
	4000 5300 2300 5300
Wire Wire Line
	2300 5400 4000 5400
Wire Wire Line
	4000 5400 4000 5500
Wire Wire Line
	4000 5600 2300 5600
Wire Wire Line
	2300 6000 3800 6000
Wire Wire Line
	3800 5800 4000 5800
Wire Wire Line
	4000 5900 3900 5900
Wire Wire Line
	3900 5900 3900 6100
Wire Wire Line
	3900 6100 2300 6100
Wire Wire Line
	4000 6100 4000 6200
Wire Wire Line
	4000 6200 2500 6200
Wire Wire Line
	2500 6200 2500 5500
Wire Wire Line
	2500 5500 2300 5500
Wire Wire Line
	2300 4900 4000 4900
Wire Wire Line
	4000 4900 4000 4700
Wire Wire Line
	4000 4600 3900 4600
Wire Wire Line
	3900 4600 3900 4800
Wire Wire Line
	3900 4800 2300 4800
Wire Wire Line
	2300 4700 3800 4700
Wire Wire Line
	3800 4700 3800 4500
Wire Wire Line
	3800 4500 4000 4500
Wire Wire Line
	4000 4400 3700 4400
Wire Wire Line
	3700 4400 3700 4600
Wire Wire Line
	3700 4600 2300 4600
Wire Wire Line
	4600 1100 4800 1100
Wire Wire Line
	4600 1850 4350 1850
Text GLabel 4800 1100 2    50   Input ~ 0
VDDIN
Text GLabel 3200 5700 2    50   Output ~ 0
VDDIN
Wire Wire Line
	2300 5900 3100 5900
Wire Wire Line
	3750 1850 3750 2400
Wire Wire Line
	4600 1550 4600 1850
Connection ~ 4600 1850
Wire Wire Line
	5000 2400 5500 2400
Wire Wire Line
	5000 1550 4950 1550
Connection ~ 5000 1850
Wire Wire Line
	5000 1850 5000 1550
Wire Wire Line
	5850 1850 5850 1950
$Comp
L power:GND #PWR?
U 1 1 60F1617D
P 5850 1950
F 0 "#PWR?" H 5850 1700 50  0001 C CNN
F 1 "GND" H 5855 1777 50  0000 C CNN
F 2 "" H 5850 1950 50  0001 C CNN
F 3 "" H 5850 1950 50  0001 C CNN
	1    5850 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60F19256
P 4700 6500
F 0 "#PWR?" H 4700 6250 50  0001 C CNN
F 1 "GND" H 4705 6327 50  0000 C CNN
F 2 "" H 4700 6500 50  0001 C CNN
F 3 "" H 4700 6500 50  0001 C CNN
	1    4700 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 3500 4000 3500
Wire Wire Line
	4700 6300 4700 6400
Text GLabel 2700 3700 2    50   Output ~ 0
GND
Wire Wire Line
	2300 3700 2400 3700
Text GLabel 4950 6400 2    50   Input ~ 0
GND
Wire Wire Line
	4700 6400 4950 6400
Connection ~ 4700 6400
Wire Wire Line
	4700 6400 4700 6500
Text GLabel 4500 2300 1    50   Output ~ 0
VDDCORE
Wire Wire Line
	4400 2400 4500 2400
Wire Wire Line
	4500 2400 4500 2300
Connection ~ 4400 2400
Text GLabel 2650 5800 2    50   Input ~ 0
VDDCORE
Wire Wire Line
	2300 5800 2650 5800
$Comp
L Device:CP C2
U 1 1 60F360C9
P 4200 2050
F 0 "C2" V 4300 2200 50  0000 C CNN
F 1 "10uF" V 4400 2200 50  0000 C CNN
F 2 "" H 4238 1900 50  0001 C CNN
F 3 "~" H 4200 2050 50  0001 C CNN
	1    4200 2050
	0    1    1    0   
$EndComp
$Comp
L Device:CP C4
U 1 1 60F37C2D
P 5400 2050
F 0 "C4" V 5300 1900 50  0000 C CNN
F 1 "10uF" V 5200 1900 50  0000 C CNN
F 2 "" H 5438 1900 50  0001 C CNN
F 3 "~" H 5400 2050 50  0001 C CNN
	1    5400 2050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4600 900  4600 1100
Connection ~ 4600 1550
Connection ~ 4600 1100
Wire Wire Line
	4600 1100 4600 1550
Wire Wire Line
	4600 1850 4600 2500
Connection ~ 5000 2400
Wire Wire Line
	5000 2400 5000 2500
Wire Wire Line
	5000 1850 5000 2400
Wire Wire Line
	2300 5700 2400 5700
Wire Wire Line
	2400 5700 2400 3700
Connection ~ 2400 3700
Wire Wire Line
	2400 3700 2700 3700
Text Notes 7250 6900 0    50   ~ 0
ATSAMD21E1xB TQFP32 very basic custom board on TQFP32 adaptor board. \nWorks for the whole ATSAMD21E1xB family on the TQFP32 (32 pin, 0.8 pitch) package.
Text Notes 7550 7500 0    50   ~ 0
ATSAMD21E1xB basic board
$Comp
L Device:L L1
U 1 1 60EF1D60
P 4800 1550
F 0 "L1" V 4619 1550 50  0000 C CNN
F 1 "10uH" V 4710 1550 50  0000 C CNN
F 2 "" H 4800 1550 50  0001 C CNN
F 3 "~" H 4800 1550 50  0001 C CNN
	1    4800 1550
	0    1    1    0   
$EndComp
Text Notes 6200 1500 0    50   ~ 0
Note: \n- C1, C3 and C5 should be placed as close as possible to the pins of the microcontroller. On an \nadaptor board for C1 and C3 you can use SMD caps size 0604 and solder them between two pins of the pin row.\n- C2 and C4 should be Tantalum. If all you have are Electrolitic Caps, use 10x larger cap values.
$Comp
L Device:R R1
U 1 1 617ED0E8
P 3550 5900
F 0 "R1" V 3343 5900 50  0000 C CNN
F 1 "1K" V 3434 5900 50  0000 C CNN
F 2 "" V 3480 5900 50  0001 C CNN
F 3 "~" H 3550 5900 50  0001 C CNN
	1    3550 5900
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 5700 3100 5700
Wire Wire Line
	3100 5700 3100 5900
Connection ~ 3100 5900
Wire Wire Line
	3100 5900 3400 5900
Wire Wire Line
	3800 5800 3800 5900
Wire Wire Line
	3700 5900 3800 5900
Connection ~ 3800 5900
Wire Wire Line
	3800 5900 3800 6000
$EndSCHEMATC
