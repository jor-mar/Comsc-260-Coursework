TITLE Add and Subtract (AddSum.asm)
; This program adds and subtracts 32-bit integers
; Jordan Marcelo

INCLUDE Irvine32.inc

.code
main PROC
	mov eax, 13500000h ; populate EAX register with 32-bit integer literal 13500000h
	add eax, 12500000h ; add 32-bit integer literal 12500000h to EAX, which held 13500000h
	sub eax, 30000000h ; subtract 32-bit integer literal 30000000h from EAX, which held running sum 13500000h + 12500000h
	call DumpRegs ; output registers to be read, 13500000h + 12500000h - 30000000h = F5A00000h, where the F represents the negative sign. Sign flag should also be called.

	exit
main ENDP
END main