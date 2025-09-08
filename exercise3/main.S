; ***********************************
; *INFORMACIÓN DEL PROYECTO*
; ***********************************
;
; *PROYECTO: Secuencias de leds
; *AUTOR: sigmotoa
; 
; *VERSION: 0.0.1
;
; *DESCRIPCIÓN:
; Manipula varios leds
;
; *HARDWARE:
; *MCU: ATtiny45 @ 8MHz Interno
; 
; 
; *CONEXIONES:
; PB0 -> resistencia ->led
; PB1 -> resistencia ->led
; PB2 -> resistencia ->led
; PB3 -> resistencia ->led
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
.global main		; xporta y hace global la etiqueta main
.org 0x0000		; Vector de RESET
	rjmp main	; Saltar al programa principal
;
; ***********************************
; * RUTINA PRINCIPAL *
; ***********************************
; 
main:
	ldi r16, 0b00001111	
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
	cpi r16, 0b00010000
	brne inicio
	
	ldi r16, 0b00001000
	
retorno:
	out PORTB, r16
	rcall delay_200
	lsr r16
	cpi r16, 0
	brne retorno
	
	rjmp loop
	
;**********************
; * SUBRUTINAS *
;**********************

delay_200:
	ldi r17, 20			
delay_ext:
	ldi r18, 125			
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
		
