$Regfile="attiny85.dat"
$Crystal=16000000
$hwstack=40
$swstack=16
$framesize=32

'########################################
'
' https://github.com/dekoch/digispark
'
'########################################

'pseudo multitasking use TIMER0
Config Timer0 = Timer , Prescale = 256
On Timer0 Scheduler
Const Timer0_Preload = 131
Load Timer0 = Timer0_Preload ' 2 ms sample
Enable Timer0
Start Timer0


Config  PORTB.1 = Output
qLED Alias Portb.1


'Variables, Subs and Functions

'pseudo multitasking
Dim T As Byte
Dim Task1 As Bit
Dim Task2 As Bit
Dim Task3 As Bit


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
   '-----------------------------
   If Task1 = 1 Then

      Waitms 100

      qLed = 1

      Waitms 10

      qLed = 0

      Waitms 100
   End If


   '-----------------------------
   If Task2 = 1 Then

      Waitms 300

      qLed = 1

      Waitms 100

      qLed = 0

      Waitms 300
   End If


   '-----------------------------
   If Task3 = 1 Then

      Waitms 300

      qLed = 1

      Waitms 300

      qLed = 0

      Waitms 300
   End If

Loop

End





Scheduler:
   Timer0 = Timer0_Preload

   Incr T

   If T >= 1 Then
      Task1 = 1
      Task2 = 0
      Task3 = 0
   End If

   If T >= 5 Then
      Task1 = 0
      Task2 = 1
      Task3 = 0
   End If

   If T >= 9 Then
      Task1 = 0
      Task2 = 0
      Task3 = 1

      T = 0
   End If

Return