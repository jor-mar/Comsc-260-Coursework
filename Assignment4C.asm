TITLE Data transfers, addressing, and arithmetic (Assignment4C.asm)
; This program completes arithmetic of variables
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
    val1 SDWORD 8
    val2 SDWORD -15
    val3 SDWORD 20

.code
main PROC

    mov eax, val2 ; EAX = FFFFFFF1
    neg eax ; EAX = 0000000F
    add eax, 7 ; EAX = 00000016
    sub eax, val3 ; EAX = 00000002
    add eax, val1 ; EAX = 0000000A

    call DumpRegs

    exit
main ENDP
END main