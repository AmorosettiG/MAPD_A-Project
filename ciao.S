
; Optional hands-on project for the MAPD A course
; Goal : write an assembly code and display "CIAO" on 7-segments displays, using an Arduino Nano

#define __SFR_OFFSET 0
#include "avr/io.h"

; --- REGISTER DEFINITIONS ---
#define TEMP r16
#define DELAY_OUT r17
#define DELAY_IN r18

.global main

; ========================
;           MAIN
; ========================
main:
    ; --- SETUP PHASE ---
    
    ; pins 0-7 (Rx0 to D6) OUTPUT for Segments
    ; We write 11111111 (0xFF) 
    ldi     TEMP, 0xFF      
    out     DDRD, TEMP

    ; pins 8-11 (d7 to d11) OUTPUT for Commons
    ; We write 00001111 (0x0F)
    ldi     TEMP, 0x0F      
    out     DDRB, TEMP

    ; Turn OFF initialization
    ldi     TEMP, 0x0F
    out     PORTB, TEMP

; --- MAIN ---
loop:

    ;   Display Letter 'C' on Digit 1 (Pin 8)
    ; Segments for C: A, D, E, F : Binary 00111001 : Hex 0x39
    ldi     TEMP, 0x39      ; Load 'C' pattern
    out     PORTD, TEMP     ; Send to segments
    
    cbi     PORTB, 0        ; Pin 8 LOW : Turn ON Digit 1
    rcall   delay_timer     ; Wait
    sbi     PORTB, 0        ; Pin 8 HIGH : Turn OFF Digit 1        

    ;   Display Letter 'I' on Digit 2 (Pin 9)
    ; Segments for I: B, C : Binary 00000110 : Hex 0x06
    ldi     TEMP, 0x06      ; Load 'I' pattern
    out     PORTD, TEMP
    
    cbi     PORTB, 1        ; Pin 9 LOW : Turn ON Digit 2
    rcall   delay_timer     ; Wait
    sbi     PORTB, 1        ; Pin 9 HIGH : Turn OFF Digit 2

    ;   Display Letter 'A' on Digit 3 (Pin 10)
    ; Segments for A: A, B, C, E, F, G : Hex 0x77
    ldi     TEMP, 0x77      ; Load 'A' pattern
    out     PORTD, TEMP
    
    cbi     PORTB, 2        ; Pin 10 LOW : Turn ON Digit 3
    rcall   delay_timer     ; Wait
    sbi     PORTB, 2        ; Pin 10 HIGH : Turn OFF Digit 3

    ;   Display Letter 'O' on Digit 4 (Pin 11)
    ; Segments for O: A, B, C, D, E, F : Hex 0x3F
    ldi     TEMP, 0x3F      ; Load 'O' pattern
    out     PORTD, TEMP
    
    cbi     PORTB, 3        ; Pin 11 LOW : Turn ON Digit 4
    rcall   delay_timer     ; Wait
    sbi     PORTB, 3        ; Pin 11 HIGH : Turn OFF Digit 4

    rjmp    loop            ; Jump back to start


; ========================
; SUBROUTINE: DELAY_TIMER
; ========================
delay_timer:
    ldi     DELAY_OUT, 10   ; Outer loop counter (Speed)
    
loop_outer:
    ldi     DELAY_IN, 255   ; Inner loop counter
    
loop_inner:
    dec     DELAY_IN        ; Decrease inner
    brne    loop_inner      ; Loop if not zero
    
    dec     DELAY_OUT       ; Decrease outer
    brne    loop_outer      ; Loop if not zero
    
    ret                     ; Return from subroutine