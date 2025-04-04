TITLE Integer Arithmetic (Assignment7A.asm)
; Jordan Marcelo

COMMENT !
Description: This program performs simple encryption by rotating
each plaintext byte based on the contents of the encryption key.
Left rotation corresponds to a negative entry in the key array,
and right rotation corresponds to a positive entry in the key array.
The integer in each location represents the magnitude of the rotation.
The program loops through the plainText and the key,
using the key to facilitate apt rotations and resetting the index of the key
when it is incremented out of the key's bounds.
!

INCLUDE Irvine32.inc

.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
keySize = $ - key
Text1 BYTE "The negative values indicate a rotation to the left and positive values indicate rotation to the right. The integer at each position indicates the magnitude of the rotation.", 0
Text2 BYTE "Your procedure should loop through a plain text message and align the key to the first 10 bytes (the key has 10 values) of the message. ", 0

.code
main PROC
    ; Display Text1
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    ; Encrypt and display Text1
    mov esi, OFFSET Text1
    mov edi, OFFSET key
    call EncryptString
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    ; Decrypt and display Text1
    mov esi, OFFSET Text1
    mov edi, OFFSET key
    call DecryptString
    mov edx, OFFSET Text1
    call WriteString
    call Crlf
    call Crlf

    call Crlf
    
    ; Display Text2
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    ; Encrypt and display Text2
    mov esi, OFFSET Text2
    mov edi, OFFSET key
    call EncryptString
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    ; Decrypt and display Text2
    mov esi, OFFSET Text2
    mov edi, OFFSET key
    call DecryptString
    mov edx, OFFSET Text2
    call WriteString
    call Crlf
    call Crlf

    exit
main ENDP

;-----------------------------------------------------
EncryptString PROC USES edi esi ecx
; Encrypt a string by rotating each byte in a specific
; direction and amount as per the key's instructions.
; Receives: ESI = addr of the plainText, EDI = key addr,
; keySize = SIZEOF key
; Returns: encrypted plainText at addr of plainText
;-----------------------------------------------------
encrypt_loop:
    ; Terminate encryption if the end of the null-terminated text is reached
    cmp BYTE PTR [esi], 0   ;   end of null-terminated string?
    je done ;   terminate encryption

    ; Load the rotation value from the key
    mov cl, [edi]   ;   move rotation value from key to cl

    ; Check if rotation is to the right or left
    ; Jumps to rotate right if rotation value is positive or 0,
    ; Otherwise rotates left
    cmp cl, 0   ;   compare cl to 0
    jge rotate_right    ;   move to rotate_right label if cl >= 0

; rotate_left:
    ; Rotate by magnitude of cl
    ; Meaning cl must be made positive if rotating left
    neg cl  ;   change cl to be positive
    rol BYTE PTR [esi], cl  ;   rotate text char @ addr[esi] left by +cl
    jmp next_char   ;   move on to encrypting next character

rotate_right:
    ror BYTE PTR [esi], cl  ;   rotate text char @ addr[esi] right by +cl

next_char:
    ; Increment to the next byte in the text and key
    inc esi ;   increment esi to move to next char in text
    inc edi ;   increment edi to move to next rotational value in key

    ; Use modulus logic to determine if the key index should be reset
    cmp edi, OFFSET key + keySize   ;   is edi out of bounds set by key length?
    jb encrypt_loop ;   if not, encrypt next char

    ; reset key counter if it is above allowable values, then resume encryption
    mov edi, OFFSET key ;   if it is out of bounds by key length, reset to beginning of key
    jmp encrypt_loop    ;   encrypt next char

done:
    ret
EncryptString ENDP

;-----------------------------------------------------
DecryptString PROC
; Decrypt a string by rotating each byte in the opposite
; direction but same amount as encryption.
; Receives: ESI = addr of the plainText, EDI = key addr,
; keySize = SIZEOF key
; Returns: decrypted plainText at addr of plainText
;-----------------------------------------------------
    ; Negate the key
    call NegateKey

    ; Encrypt the string with the negated key
    ; Which reverses known encryption
    call EncryptString

    ; Restore the key by negating it again
    call NegateKey

    ret
DecryptString ENDP

;-----------------------------------------------------
NegateKey PROC USES ecx edi
; Makes every element of a byte array key negative
; Receives: EDI = key addr, keySize = SIZEOF key
; Returns: negated array at addr of key
;-----------------------------------------------------
    ; Initialize counter
    mov ecx, keySize

negate_loop:
    ; Negate the current byte in the key,
    ; updating its value accordingly
    mov ch, [edi]
    neg ch
    mov [edi], ch
    xor ch, ch  ;   clear ch for future operations

    ; Move to the next byte
    inc edi

    ; Loop through the key
    loop negate_loop

    ret
NegateKey ENDP

END main