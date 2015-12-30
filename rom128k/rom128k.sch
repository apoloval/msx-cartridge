EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
EELAYER 25 0
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
L CONN_02X25 P1
U 1 1 5683C854
P 3000 3600
F 0 "P1" H 3000 4900 50  0000 C CNN
F 1 "CONN_02X25" V 3000 3600 50  0000 C CNN
F 2 "" H 3000 2850 60  0000 C CNN
F 3 "" H 3000 2850 60  0000 C CNN
	1    3000 3600
	1    0    0    -1  
$EndComp
Text Label 2350 3200 0    60   ~ 0
A9
Text Label 2350 3300 0    60   ~ 0
A11
Text Label 2350 3400 0    60   ~ 0
A7
Text Label 2350 3500 0    60   ~ 0
A12
Text Label 2350 3600 0    60   ~ 0
A14
Text Label 2350 3700 0    60   ~ 0
A1
Text Label 2350 3800 0    60   ~ 0
A3
Text Label 2350 3900 0    60   ~ 0
A5
Text Label 3650 3200 2    60   ~ 0
A15
Text Label 3650 3300 2    60   ~ 0
A10
Text Label 3650 3400 2    60   ~ 0
A6
Text Label 3650 3500 2    60   ~ 0
A8
Text Label 3650 3600 2    60   ~ 0
A13
Text Label 3650 3700 2    60   ~ 0
A0
Text Label 3650 3800 2    60   ~ 0
A2
Text Label 3650 3900 2    60   ~ 0
A4
Wire Wire Line
	3650 3200 3250 3200
Wire Wire Line
	3250 3300 3650 3300
Wire Wire Line
	3250 3400 3650 3400
Wire Wire Line
	3250 3500 3650 3500
Wire Wire Line
	3250 3600 3650 3600
Wire Wire Line
	3250 3700 3650 3700
Wire Wire Line
	3250 3800 3650 3800
Wire Wire Line
	3250 3900 3650 3900
Entry Wire Line
	3650 3900 3750 3800
Entry Wire Line
	3650 3800 3750 3700
Entry Wire Line
	3650 3700 3750 3600
Entry Wire Line
	3650 3600 3750 3500
Entry Wire Line
	3650 3500 3750 3400
Entry Wire Line
	3650 3400 3750 3300
Entry Wire Line
	3650 3300 3750 3200
Entry Wire Line
	3650 3200 3750 3100
Wire Wire Line
	2350 3200 2750 3200
Wire Wire Line
	2750 3300 2350 3300
Wire Wire Line
	2350 3400 2750 3400
Wire Wire Line
	2750 3500 2350 3500
Wire Wire Line
	2350 3600 2750 3600
Wire Wire Line
	2750 3700 2350 3700
Wire Wire Line
	2350 3800 2750 3800
Wire Wire Line
	2750 3900 2350 3900
Entry Wire Line
	2250 3100 2350 3200
Entry Wire Line
	2250 3200 2350 3300
Entry Wire Line
	2250 3300 2350 3400
Entry Wire Line
	2250 3400 2350 3500
Entry Wire Line
	2250 3500 2350 3600
Entry Wire Line
	2250 3600 2350 3700
Entry Wire Line
	2250 3700 2350 3800
Entry Wire Line
	2250 3800 2350 3900
Wire Bus Line
	2250 3050 2250 3900
Text Notes 3850 3150 3    60   ~ 0
ADDRESS BUS
Text Notes 2200 3700 1    60   ~ 0
ADDRESS BUS
Text Label 2350 4000 0    60   ~ 0
D1
Text Label 2350 4100 0    60   ~ 0
D3
Text Label 2350 4200 0    60   ~ 0
D5
Text Label 2350 4300 0    60   ~ 0
D7
Wire Bus Line
	3750 3900 3750 3050
Text Label 3650 4000 2    60   ~ 0
D0
Text Label 3650 4100 2    60   ~ 0
D2
Text Label 3650 4200 2    60   ~ 0
D4
Text Label 3650 4300 2    60   ~ 0
D6
Wire Wire Line
	3250 4000 3650 4000
Wire Wire Line
	3650 4100 3250 4100
Wire Wire Line
	3250 4200 3650 4200
Wire Wire Line
	3650 4300 3250 4300
Wire Wire Line
	2750 4300 2350 4300
Wire Wire Line
	2350 4200 2750 4200
Wire Wire Line
	2750 4100 2350 4100
Wire Wire Line
	2350 4000 2750 4000
Entry Wire Line
	3650 4000 3750 4100
Entry Wire Line
	3650 4100 3750 4200
Entry Wire Line
	3650 4200 3750 4300
Entry Wire Line
	3650 4300 3750 4400
Entry Wire Line
	2250 4400 2350 4300
Entry Wire Line
	2250 4300 2350 4200
Entry Wire Line
	2250 4200 2350 4100
Entry Wire Line
	2250 4100 2350 4000
Wire Bus Line
	3750 4050 3750 4450
Wire Bus Line
	2250 4050 2250 4450
Text Notes 3850 4450 1    60   ~ 0
DATA BUS
Text Notes 2200 4450 1    60   ~ 0
DATA BUS
$Comp
L GND #PWR01
U 1 1 5683ED06
P 2450 4900
F 0 "#PWR01" H 2450 4650 50  0001 C CNN
F 1 "GND" H 2450 4750 50  0000 C CNN
F 2 "" H 2450 4900 60  0000 C CNN
F 3 "" H 2450 4900 60  0000 C CNN
	1    2450 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 4400 2450 4400
Wire Wire Line
	2450 4400 2450 4900
Wire Wire Line
	2750 4500 2450 4500
Connection ~ 2450 4500
$Comp
L VCC #PWR02
U 1 1 5683EDDA
P 2650 4900
F 0 "#PWR02" H 2650 4750 50  0001 C CNN
F 1 "VCC" H 2650 5050 50  0000 C CNN
F 2 "" H 2650 4900 60  0000 C CNN
F 3 "" H 2650 4900 60  0000 C CNN
	1    2650 4900
	-1   0    0    1   
$EndComp
Wire Wire Line
	2650 4900 2650 4600
Wire Wire Line
	2650 4600 2750 4600
Wire Wire Line
	2750 4700 2650 4700
Connection ~ 2650 4700
NoConn ~ 2750 4800
NoConn ~ 3250 4800
NoConn ~ 3250 4700
Wire Wire Line
	3250 4600 3400 4600
Wire Wire Line
	3400 4600 3400 4500
Wire Wire Line
	3400 4500 3250 4500
NoConn ~ 3250 4400
Text GLabel 3450 3000 2    60   Output ~ 0
~RD
Text GLabel 3450 2500 2    60   Output ~ 0
~SLTSL
Wire Wire Line
	3250 2500 3450 2500
Wire Wire Line
	3450 3000 3250 3000
NoConn ~ 3250 3100
NoConn ~ 2750 3100
NoConn ~ 2750 3000
NoConn ~ 3250 2900
NoConn ~ 2750 2900
NoConn ~ 3250 2800
NoConn ~ 3250 2700
NoConn ~ 3250 2600
NoConn ~ 3250 2400
NoConn ~ 2750 2400
NoConn ~ 2750 2500
NoConn ~ 2750 2600
NoConn ~ 2750 2700
NoConn ~ 2750 2800
$EndSCHEMATC
