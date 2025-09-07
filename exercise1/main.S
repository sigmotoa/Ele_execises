;=====================
; *PROYECTO: led encendido
; *AUTOR: sigmotoa
; *VERSION: 0.0.2
;
; *DESCRIPCIÓN:
; Se enciende un led en PORTB0
; 
; *HARDWARE:
; *MCU: ATtiny45 @ 8MHz Interno
;
; *CONEXIONES:
; PB0 -> resistencia ->led
;
;=======================
;**********************
; * DEFINICIONES *
;**********************
.include "tn45def.inc"

;**********************
; * VECTOR DE RESET *
;**********************

.global main
.org 0x0000
	rjmp main

;**********************
; * MAIN *
;**********************

main:
	ldi r16, 1
	out DDRB, r16
	
;**********************
; * CICLO PRINCIPAL *
;**********************
loop:
	sbi PORTB, 0
	rjmp loop
	