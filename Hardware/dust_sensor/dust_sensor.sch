EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "SoPEM PM10 Sensor"
Date "2020-06-20"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Amplifier_Operational:LM358 U1
U 1 1 5EF3CBDC
P 6450 3150
F 0 "U1" H 6450 3500 50  0000 C CNN
F 1 "LM358" H 6450 3400 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm_LongPads" H 6450 3150 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 6450 3150 50  0001 C CNN
	1    6450 3150
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:LM358 U1
U 2 1 5EF3E222
P 6950 4600
F 0 "U1" H 6950 4875 50  0000 C CNN
F 1 "LM358" H 6950 4966 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm_LongPads" H 6950 4600 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 6950 4600 50  0001 C CNN
	2    6950 4600
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:LM358 U1
U 3 1 5EF3F4C1
P 4600 3100
F 0 "U1" H 4558 3146 50  0000 L CNN
F 1 "LM358" H 4558 3055 50  0000 L CNN
F 2 "Package_DIP:DIP-8_W7.62mm_LongPads" H 4600 3100 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 4600 3100 50  0001 C CNN
	3    4600 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R4
U 1 1 5EF409ED
P 6950 4200
F 0 "R4" V 6745 4200 50  0000 C CNN
F 1 "10Meg" V 6836 4200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6990 4190 50  0001 C CNN
F 3 "~" H 6950 4200 50  0001 C CNN
	1    6950 4200
	0    1    1    0   
$EndComp
$Comp
L Device:D_Photo D2
U 1 1 5EF41176
P 6100 4850
F 0 "D2" V 6004 4771 50  0000 R CNN
F 1 "D_Photo" V 6095 4771 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm_Horizontal_O1.27mm_Z3.0mm_IRBlack" H 6050 4850 50  0001 C CNN
F 3 "~" H 6050 4850 50  0001 C CNN
	1    6100 4850
	0    1    1    0   
$EndComp
$Comp
L Device:LED D1
U 1 1 5EF41816
P 5250 4650
F 0 "D1" V 5289 4533 50  0000 R CNN
F 1 "LED" V 5198 4533 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm_Horizontal_O1.27mm_Z3.0mm_Clear" H 5250 4650 50  0001 C CNN
F 3 "~" H 5250 4650 50  0001 C CNN
	1    5250 4650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6800 4200 6500 4200
Wire Wire Line
	6500 4200 6500 4500
Wire Wire Line
	6500 4500 6650 4500
Wire Wire Line
	7100 4200 7400 4200
Wire Wire Line
	7400 4200 7400 4600
Wire Wire Line
	7400 4600 7250 4600
Wire Wire Line
	6100 4650 6100 4500
Wire Wire Line
	6100 4500 6500 4500
Connection ~ 6500 4500
$Comp
L power:GND #PWR08
U 1 1 5EF460E3
P 6100 4950
F 0 "#PWR08" H 6100 4700 50  0001 C CNN
F 1 "GND" H 6105 4777 50  0000 C CNN
F 2 "" H 6100 4950 50  0001 C CNN
F 3 "" H 6100 4950 50  0001 C CNN
	1    6100 4950
	1    0    0    -1  
$EndComp
$Comp
L power:REF #PWR09
U 1 1 5EF46A5A
P 6500 4950
F 0 "#PWR09" H 6500 4700 50  0001 C CNN
F 1 "REF" H 6505 4777 50  0000 C CNN
F 2 "" H 6500 4950 50  0001 C CNN
F 3 "" H 6500 4950 50  0001 C CNN
	1    6500 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 4950 6500 4700
Wire Wire Line
	6500 4700 6650 4700
$Comp
L Device:R_US R1
U 1 1 5EF4D14D
P 5250 4150
F 0 "R1" H 5182 4104 50  0000 R CNN
F 1 "220" H 5182 4195 50  0000 R CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5290 4140 50  0001 C CNN
F 3 "~" H 5250 4150 50  0001 C CNN
	1    5250 4150
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5EF4DAC9
P 5250 4950
F 0 "#PWR05" H 5250 4700 50  0001 C CNN
F 1 "GND" H 5255 4777 50  0000 C CNN
F 2 "" H 5250 4950 50  0001 C CNN
F 3 "" H 5250 4950 50  0001 C CNN
	1    5250 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 4300 5250 4500
Wire Wire Line
	5250 4800 5250 4950
Text GLabel 7500 4600 2    50   Output ~ 0
SENSOR_OUT
Wire Wire Line
	7400 4600 7500 4600
Connection ~ 7400 4600
Text GLabel 5250 3850 1    50   Input ~ 0
LED_IR_CTRL
Wire Wire Line
	5250 3850 5250 4000
$Comp
L Device:R_US R2
U 1 1 5EF51BA2
P 5800 2850
F 0 "R2" H 5867 2804 50  0000 L CNN
F 1 "10K" H 5867 2895 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5840 2840 50  0001 C CNN
F 3 "~" H 5800 2850 50  0001 C CNN
	1    5800 2850
	-1   0    0    1   
$EndComp
$Comp
L Device:R_US R3
U 1 1 5EF521D5
P 5800 3250
F 0 "R3" H 5867 3204 50  0000 L CNN
F 1 "10K" H 5867 3295 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5840 3240 50  0001 C CNN
F 3 "~" H 5800 3250 50  0001 C CNN
	1    5800 3250
	-1   0    0    1   
$EndComp
Wire Wire Line
	5800 3050 5800 3000
Wire Wire Line
	5800 3050 6150 3050
Wire Wire Line
	5800 3050 5800 3100
Connection ~ 5800 3050
Wire Wire Line
	6050 3250 6050 3450
Wire Wire Line
	6050 3450 6850 3450
Wire Wire Line
	6850 3450 6850 3150
Wire Wire Line
	6850 3150 6750 3150
Wire Wire Line
	6050 3250 6150 3250
$Comp
L power:GND #PWR07
U 1 1 5EF554B1
P 5800 3400
F 0 "#PWR07" H 5800 3150 50  0001 C CNN
F 1 "GND" H 5805 3227 50  0000 C CNN
F 2 "" H 5800 3400 50  0001 C CNN
F 3 "" H 5800 3400 50  0001 C CNN
	1    5800 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR06
U 1 1 5EF55C5B
P 5800 2700
F 0 "#PWR06" H 5800 2550 50  0001 C CNN
F 1 "+3.3V" H 5815 2873 50  0000 C CNN
F 2 "" H 5800 2700 50  0001 C CNN
F 3 "" H 5800 2700 50  0001 C CNN
	1    5800 2700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 5EF59B22
P 4500 2800
F 0 "#PWR03" H 4500 2650 50  0001 C CNN
F 1 "+3.3V" H 4515 2973 50  0000 C CNN
F 2 "" H 4500 2800 50  0001 C CNN
F 3 "" H 4500 2800 50  0001 C CNN
	1    4500 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5EF5A1D6
P 4500 3400
F 0 "#PWR04" H 4500 3150 50  0001 C CNN
F 1 "GND" H 4505 3227 50  0000 C CNN
F 2 "" H 4500 3400 50  0001 C CNN
F 3 "" H 4500 3400 50  0001 C CNN
	1    4500 3400
	1    0    0    -1  
$EndComp
$Comp
L power:REF #PWR010
U 1 1 5EF5A917
P 6950 3150
F 0 "#PWR010" H 6950 2900 50  0001 C CNN
F 1 "REF" V 6955 3022 50  0000 R CNN
F 2 "" H 6950 3150 50  0001 C CNN
F 3 "" H 6950 3150 50  0001 C CNN
	1    6950 3150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6950 3150 6850 3150
Connection ~ 6850 3150
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 5EF5BBDD
P 3300 4300
F 0 "J1" H 3408 4581 50  0000 C CNN
F 1 "Main conn" H 3408 4490 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 3300 4300 50  0001 C CNN
F 3 "~" H 3300 4300 50  0001 C CNN
	1    3300 4300
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR02
U 1 1 5EF5C7AF
P 3600 4400
F 0 "#PWR02" H 3600 4250 50  0001 C CNN
F 1 "+3.3V" V 3615 4528 50  0000 L CNN
F 2 "" H 3600 4400 50  0001 C CNN
F 3 "" H 3600 4400 50  0001 C CNN
	1    3600 4400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5EF5D5C0
P 3600 4500
F 0 "#PWR01" H 3600 4250 50  0001 C CNN
F 1 "GND" V 3605 4372 50  0000 R CNN
F 2 "" H 3600 4500 50  0001 C CNN
F 3 "" H 3600 4500 50  0001 C CNN
	1    3600 4500
	0    -1   -1   0   
$EndComp
Text GLabel 3600 4200 2    50   Output ~ 0
LED_IR_CTRL
Text GLabel 3600 4300 2    50   Input ~ 0
SENSOR_OUT
Wire Wire Line
	3500 4400 3600 4400
Wire Wire Line
	3600 4500 3500 4500
Wire Wire Line
	3500 4300 3600 4300
Wire Wire Line
	3600 4200 3500 4200
Text Notes 6850 2950 0    50   ~ 0
Il buffer crea un riferimento fisso a VCC/2, utile per \nl’implementazione futura di ulteriori stadi
Text Notes 7200 4100 0    50   ~ 0
La resistenza di feedback è stata dimensionata sperimentalmente,\nL’amplificazione necessaria è strettamente dipendente dal fotodiodo\nusato
Text Notes 4700 5500 0    50   ~ 0
Il LED deve lavorare nello spettro infrarosso, mentre il fotodiodo,\noltre a dover captare gli IR, dovrebbe essere schermato dalla luce\nsolare.
$EndSCHEMATC
