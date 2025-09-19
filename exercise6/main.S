; ***********************************
; *INFORMACIÓN DEL PROYECTO*
; ***********************************
;
; *PROYECTO: contador con anti-rebote sin delays
; *AUTOR: sigmotoa
; *FECHA: 19/09/2025
; *VERSION: 0.0.6
;
; *DESCRIPCIÓN:
; Leer un pulsador, hacer un conteo con anti-rebote
;
; *HARDWARE:
; *MCU: ATTiny 45 @ 8MHz
;
; *CONEXIONES:
; PB4 - res (220) - led
; PB5 - pulsador 
; PB0..PB3 - conversor BCD a 7 segmentos
;
; ***********************************
; * DEFINICIONES *
; ***********************************
;
.include "tn45def.inc"
;
; ***********************************
; * VECTOR DE RESET *
; ************************************
;
.global main
.org 0x0000
    rjmp main

main:
    ldi r16, 0b00011111     ; PB0..PB4 -> salidas (PB5 entrada)
    out DDRB, r16
    ldi r16, 0b00100000     ; Pull-up en PB5
    out PORTB, r16

    clr r18                 ; contador = 0
    ldi r19, 0x20           ; estado previo = PB5 alto (no presionado)

    ; Inicializar display a 0 (preservando PB4/PB5)
    mov r20, r18
    andi r20, 0x0F
    in r16, PORTB
    andi r16, 0b00110000    ; preservar bits PB4 y PB5 (bits 4 y 5)
    or r16, r20
    out PORTB, r16

; ================================
; Bucle principal
; ================================
loop:
    in r17, PINB            ; leer PINB
    andi r17, 0b00100000    ; aislar PB5 -> r17 = 0x20 o 0x00

    ; --- LED: encendido mientras presionas (PB5 = 0) ---
    cpi r17, 0x00
    brne led_off
    sbi PORTB, 4            ; PB4 = 1 (LED on)
    rjmp check_flanco

led_off:
    cbi PORTB, 4            ; PB4 = 0 (LED off)

check_flanco:
    ; Detectar flanco descendente: ANTES = 1 (0x20) Y AHORA = 0x00
    cpi r19, 0x20
    brne update_prev
    cpi r17, 0x00
    brne update_prev

    ; ===========================
    ;  <-- Aquí se confirma la pulsación, poner todo lo que se debe hacer luego del pulso-->
    inc r18
    andi r18, 0x0F

    ; Actualizar display preservando PB4/PB5
    mov r20, r18
    andi r20, 0x0F
    in r16, PORTB
    andi r16, 0b00110000
    or r16, r20
    out PORTB, r16
    ; ===========================

update_prev:
    mov r19, r17            ; guardar estado actual (previo <- actual)
    rjmp loop
