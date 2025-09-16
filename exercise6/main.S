; ***********************************
; *INFORMACIÓN DEL PROYECTO*
; ***********************************
;
; *PROYECTO: contador simple + 7segmentos
; *AUTOR: sigmotoa
; *FECHA: 16/09/2025
; *VERSION: 0.0.1
;
; *DESCRIPCIÓN:
; Leer un pulsador hacer un conteo
;
; *HARDWARE:
; *MCU:	ATTiny 45 @ 8MHz
; 
; 
; *CONEXIONES:
; PB4 - res (220) - led
; PB5 - pulsador
; PB0..PB3 7 segmentos
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
	ldi r16, 0b00011111	;carga un 0b00000001 en el registro r16
	out DDRB, r16	;mueve el valor del registro al regitro de direcciones haciendo que el bit 0 del puerto sea de salida, PB0
	ldi r16, 0b00100000 ;Activar resistencia de pull-up
	out PORTB, r16
	ldi r18, 0
;
; ***********************************
; * CICLO PRINCIPAL *
; ***********************************
loop:
	in r17, PINB  ;leer el puerto b
	andi r17, 0b00100000
	
	breq led_on
	
led_off:
	cbi PORTB, 4 ;poner en bajo el puerto B pin0
	rjmp loop
	
led_on:
	sbi PORTB, 4  ;poner en alto el pin0 portb
	in r19, PINB
	andi r19, 0b00100000
	breq increment
	
	
increment:
	inc r18
	out PORTB, r18
	rjmp loop
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
