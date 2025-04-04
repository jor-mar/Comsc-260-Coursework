TITLE Add and Subtract B (AddSumB.asm)
; This program adds and subtracts 32-bit integers using variables
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
a DWORD 13500000h ; assign 13500000h to 32-bit unsigned integer variable a
b DWORD 12500000h ; assign 12500000h to 32-bit unsigned integer variable b
cc DWORD 10000000h ; assign 10000000h to 32-bit unsigned integer variable cc
d DWORD 35900000h ; assign 35900000h to 32-bit unsigned integer variable d

.code
main PROC
	mov eax, a ; populate register EAX with first variable A
	add eax, b ; add variable b to register EAX, which held variable A
	sub eax, cc ; subtract variable cc from register EAX, which held a+b
	add eax, d ; add variable d to register EAX, which held a+b-cc
	call DumpRegs ; output registers to be read: a+b-cc+d

	exit
main ENDP
END main