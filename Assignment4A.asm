TITLE Data transfers, addressing, and arithmetic (Assignment4A.asm)
; This program different parts of an array to different registers
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
    Uarray WORD 1000h, 2000h, 3000h, 4000h
    Sarray SWORD -1, -2, -3, -4

.code
main PROC

    movzx eax, WORD PTR [Uarray]   ; Move first element (1000h) into EAX with 4 0s in front
    movzx ebx, WORD PTR [Uarray+2] ; Move second element (2000h) into EBX with 4 0s in front
    movzx ecx, WORD PTR [Uarray+4] ; Move third element (3000h) into ECX with 4 0s in front
    movzx edx, WORD PTR [Uarray+6] ; Move fourth element (4000h) into EDX with 4 0s in front

    call DumpRegs ; Display register values

    movsx eax, WORD PTR [Sarray] ; Move first element (FFFFFFFF) into EAX with 4 sign bits in front
    movsx ebx, WORD PTR [Sarray+2] ; Move second element (FFFFFFFE) into EAX with 4 sign bits in front
    movsx ecx, WORD PTR [Sarray+4] ; Move third element (FFFFFFFD) into EAX with 4 sign bits in front
    movsx edx, WORD PTR [Sarray+6] ; Move fourth element (FFFFFFFC) into EAX with 4 sign bits in front

    call DumpRegs ; Display register values

    exit
main ENDP
END main