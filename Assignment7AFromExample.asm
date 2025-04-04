TITLE Integer Arithmetic (Assigment7A.asm)
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
keySize = $ - key
Text1 BYTE "The negative values indicate a rotation to the left and positive values indicate rotation to the right. The integer at each position indicates the magnitude of the rotation.", 0
Text2 BYTE "Your procedure should loop through a plain text message and align the key to the first 10 bytes (the key has 10 values) of the message. ", 0


.code
main PROC
    call Clrscr

    ; display Text1
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    ; encrypt and display encrypted Text1
    mov esi, OFFSET Text1
    call EncryptString
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    ; decrypt and display decrypted Text1
    mov esi, OFFSET Text1
    call DecryptString
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf
    
    call Crlf

    ; write Text2
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    ; encrypt and display encrypted Text2
    mov esi, OFFSET Text2
    call EncryptString
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    ; decrypt and display decrypted Text2
    mov esi, OFFSET Text2
    call DecryptString
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    exit
main ENDP


EncryptString PROC USES eax ecx
L1:
    mov ecx, keySize
    mov edi, OFFSET key
    call encode_key
    jnz L1
    ret
EncryptString ENDP

encode_key PROC
begin:
    push ecx
    cmp BYTE PTR[esi], 0
    je pop_ecx

    mov cl, [edi]
    cmp cl, 0
    jge rotate_right
; rotate left if cl < 0
    neg cl
    rol BYTE PTR[esi], cl
    jmp increment

rotate_right:
    ror BYTE PTR[esi], cl

increment:
    inc esi
    inc edi
    pop ecx
    loop begin
    or eax, 1
    jmp return

pop_ecx:
    pop ecx

return:
    ret
encode_key ENDP

DecryptString PROC
    call NegateKey
    call EncryptString
    call NegateKey
    ret
DecryptString ENDP

NegateKey PROC USES eax
    mov edi, OFFSET key
    mov ecx, keySize
L1:
    mov al, [edi]
    neg al
    mov [edi], al
    inc edi
    loop L1
    ret
NegateKey ENDP

END main