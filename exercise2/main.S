; ***********************************
; *INFORMACIÓN DEL PROYECTO*
; ***********************************
;
; *PROYECTO: Led parpadeando
; *AUTOR: sigmotoa
;
; *VERSION: 0.0.1
;
; *DESCRIPCIÓN:
; Enciende un led en PORTB0 y lo hace parpadear, los delay son generados por instrucciones de salto
;
; 1 ciclo = 1/8000000 = 125ns -> costo de una instruccion simple
; 
; 1000 instrucciones = 125 us
; 8000 instrucciones = 1ms
;
; *HARDWARE:
; *MCU:	ATtiny @ 8MHz Interno
; 
; 
; *CONEXIONES:
; PB0 -> resistencia ->led
;
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
	ldi r16, 0
	out PORTB, r16
	
;**********************
; * CICLO PRINCIPAL *
;**********************
loop:
;led enciende
	sbi PORTB, 0
	rcall delay_principal
	
;led apaga
	cbi PORTB, 0
	rcall delay_principal
	
	rjmp loop
	
; ***********************************
; * SUB-RUTINAS *
; ***********************************

delay_principal:
	ldi r17, 8
	
ciclo_externo:
	ldi r18, 250

ciclo_medio:
	ldi r19, 250

ciclo_interno:
	nop
	dec r19
	brne ciclo_interno
	
	dec r18
	brne ciclo_medio
	
	dec r17
	brne ciclo_externo
	
	ret

	
	
	
	
	
