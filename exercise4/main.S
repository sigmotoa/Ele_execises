; ***********************************
; *INFORMACIÓN DEL PROYECTO*
; ***********************************
;
; *PROYECTO: Semaforo LEDs
; *AUTOR: sigmotoa
; 
; *VERSION: 0.0.1
;
; *DESCRIPCIÓN:
; Manipula varios leds emulando un semaforo
;
; *HARDWARE:
; *MCU: ATtiny45 @ 8MHz Interno
; 
; 
; *CONEXIONES:
; PB0 -> resistencia ->led (rojo)
; PB1 -> resistencia ->led (amarillo)
; PB2 -> resistencia ->led (verde)
; 
;
;
; 
;
; ***********************************
; * DEFINICIONES *
; ***********************************
;
;
.include "tn45def.inc"
;
; ***********************************
;  * VECTOR DE RESET *
; ************************************

;
.global main		
.org 0x0000		
	rjmp main	
;
; ***********************************
; * RUTINA PRINCIPAL *
; ***********************************
; 
main:
	ldi r16, 0b00000111	
	out DDRB, r16
	ldi r16, 0
	out PORTB, r16

; ***********************************
; * CICLO PRINCIPAL *
; ***********************************

loop:
	ldi r16, 1
	
inicio:
	out PORTB, r16
	rcall delay_200
	lsl r16
	out PORTB, r16
	rcall delay_100
	lsl r16
	out PORTB, r16
	cpi r16, 0b00000100
	rcall delay_200
	
retorno:
	out PORTB, r16
	rcall delay_200
	lsr r16
	out PORTB, r16
	rcall delay_100
	lsr r16
	out PORTB, r16
	rcall delay_200
	lsr r16
	cpi r16, 0
	
	rjmp main
	
;**********************
; * SUBRUTINAS *
;**********************

delay_100:
	ldi r17, 8
delay_ext1:
	ldi r18, 125
delay_med1:
	ldi r19, 100
delay_int1:
	nop
	dec r19
	brne delay_int1
	
	dec r18
	brne delay_med1
	
	dec r17
	brne delay_ext1
	
	ret


delay_200:
	ldi r17, 100			
delay_ext:
	ldi r18, 200		
delay_med:
	ldi r19, 200			
delay_int:
	nop				
	dec r19				
	brne delay_int		
	
	dec r18				
	brne delay_med			
	
	dec r17				
	brne delay_ext			
	
	ret				
		
