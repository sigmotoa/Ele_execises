.include "tn45def.inc"

.global main
.org 0x0000
	rjmp main
	
main:
	ldi r16, 1
	out DDRB, r16
loop:
	sbi PORTB, 0
	rjmp loop
	