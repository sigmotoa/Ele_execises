; ***********************************
; *INFORMACIÓN DEL PROYECTO*
; ***********************************
;
; *PROYECTO: leer pulsador
; *AUTOR: sigmotoa
; *FECHA: 16/09/2025
; *VERSION: 0.0.1
;
; *DESCRIPCIÓN:
; Leer un pulsador y encender un led
;
; *HARDWARE:
; *MCU:	ATTiny 45 @ 8MHz
; 
; 
; *CONEXIONES:
; PB0 - res (220) - led
; PB1 - pulsador
;
;
; ***********************************
; * DEFINICIONES *
; ***********************************
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
main:
	ldi r16, 0b00000001	;carga un 0b00000001 en el registro r16
	out DDRB, r16	;mueve el valor del registro al regitro de direcciones haciendo que el bit 0 del puerto sea de salida, PB0
	ldi r16, 0b00000010 ;Activar resistencia de pull-up
	out PORTB, r16
;
; ***********************************
; * CICLO PRINCIPAL *
; ***********************************
loop:
	in r17, PINB  ;leer el puerto b
	andi r17, 0b00000010
	
	breq led_on
	
led_off:
	cbi PORTB, 0 ;poner en bajo el puerto B pin0
	rjmp loop
	
led_on:
	sbi PORTB, 0  ;poner en alto el pin0 portb
	rjmp loop
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
