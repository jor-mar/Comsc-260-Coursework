INCLUDE Irvine32.inc

.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
keySize = $ - key
Text1 BYTE "The negative values indicate a rotation to the left and positive values indicate rotation to the right. The integer at each position indicates the magnitude of the rotation.", 0
Text2 BYTE "Your procedure should loop through a plain text message and align the key to the first 10 bytes (the key has 10 values) of the message. ", 0

.code
main PROC
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    mov esi, OFFSET Text1
    mov edi, OFFSET key
    call EncryptString
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    mov esi, OFFSET Text1
    mov edi, OFFSET key
    call DecryptString
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    call Crlf
    
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    mov esi, OFFSET Text2
    mov edi, OFFSET key
    call EncryptString
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    mov esi, OFFSET Text2
    mov edi, OFFSET key
    call DecryptString
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    exit
main ENDP

EncryptString PROC USES edi esi ecx
encrypt_loop:
    cmp BYTE PTR [esi], 0
    je done

    mov cl, [edi]
    cmp cl, 0
    jge rotate_right
    neg cl
    rol BYTE PTR [esi], cl
    jmp next_char

rotate_right:
    ror BYTE PTR [esi], cl

next_char:
    inc esi
    inc edi
    cmp edi, OFFSET key + keySize
    jb encrypt_loop
    mov edi, OFFSET key
    jmp encrypt_loop

done:
    ret
EncryptString ENDP

DecryptString PROC
    call NegateKey
    call EncryptString
    call NegateKey
    ret
DecryptString ENDP

NegateKey PROC USES ecx edi
    mov ecx, keySize
negate_loop:
    mov ch, [edi]
    neg ch
    mov [edi], ch
    xor ch, ch
    inc edi
    loop negate_loop
    ret
NegateKey ENDP

END main