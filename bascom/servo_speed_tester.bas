$Regfile="attiny85.dat"
$Crystal=16000000
$hwstack=40
$swstack=16
$framesize=32

'########################################
'
' https://github.com/dekoch/digispark
'
' description:
' connect P0 to servo-PWM input
' and P1 to your oscilloscope CH1
' disassemble the servo and connect the middle potentiometer
' pin to oscilloscope CH2
'
'########################################

'Config Servos use TIMER0
Config Servos = 1 , Servo1 = Portb.0 , Reload = 10


Config  PORTB.1 = Output
qLED Alias Portb.1


'Variables, Subs and Functions
Dim bTestStep As Byte
Dim bNewAngle As Byte


Const cMinAngle = 50

bNewAngle = cMinAngle
Servo(1) = cMinAngle


Enable Interrupts


'hello sequence
qLed = 1

Waitms 500

qLed = 0

Waitms 500

qLed = 1

Wait 1

qLed = 0



Do

   If bTestStep >= 4 Then

      bTestStep = 0
   Else

      bTestStep = bTestStep + 1
   End If


   Select Case bTestStep

      Case 0:
         bNewAngle = cMinAngle + 10

      Case 1:
         bNewAngle = cMinAngle + 20

      Case 2:
         bNewAngle = cMinAngle + 40

      Case 3:
         bNewAngle = cMinAngle + 80

      Case 4:
         bNewAngle = cMinAngle + 120

   End Select


   qLed = 1

   Waitms bNewAngle

   qLed = 0

   Servo(1) = bNewAngle


   Waitms 750

   Servo(1) = cMinAngle

   Waitms 750

Loop

End