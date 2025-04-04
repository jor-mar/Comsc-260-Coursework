TITLE Data transfers, addressing, and arithmetic (Assignment4B.asm)
; This program reverses an array
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
    array DWORD 1, 2, 3, 4, 0Ah, 0Bh

.code
    main PROC

    mov esi, OFFSET array ; stores pointer to first element of array in esi
    mov edi, OFFSET array + SIZEOF array - TYPE array ; stores pointer to last element of array in edi
    mov ecx, LENGTHOF array / 2 ; the number of times to complete the loop L1

L1:
    mov eax, [esi] ; eax = former first element of array
    xchg eax, [edi] ; eax = former last element of array, new last element of array = former first element of array
    mov [esi], eax ; new first element of array = former last element of array

    add esi, TYPE array ; increments esi to memory address of next element of array in former half
    sub edi, TYPE array ; increments edi to memory address of previous element of array in latter half
    ; this repeats until ecx is 0
    ; ie. until first half of array has been swapped with relative last half counterpart
    loop L1

    mov esi, OFFSET array
    mov ecx, LENGTHOF array
    mov ebx, TYPE array
    ; moves certain attributes to register to be seen, if wanted

    call DumpMem ; shows memory: completely reversed array

    exit
main ENDP
END main