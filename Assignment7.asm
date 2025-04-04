TITLE Encryption Program (Assignment7.asm)
; This program encrypts a plain text message via a procedure
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
keySize = $ - key

plainText1 BYTE "The negative values indicate a rotation to the left and positive values indicate rotation to the right. The integer at each position indicates the magnitude of the rotation.", 0
plainText2 BYTE "Your procedure should loop through a plain text message and align the key to the first 10 bytes (the key has 10 values) of the message. ", 0

encryptedText1 BYTE SIZEOF plainText1 DUP (?)
encryptedText2 BYTE SIZEOF plainText2 DUP (?)

msgPlain BYTE "Original: ", 0
msgEncrypted BYTE "Encrypted: ", 0


.code
main PROC
	call Clrscr

	mov esi, 0
	mov ecx, LENGTHOF plainText1 - 1
L1:
	call index_mod_key
	mov al, plainText1[esi]
	call encrypt_char
	mov encryptedText1[esi], al
	inc esi
	loop L1

	mov esi, 0
	mov ecx, LENGTHOF plainText2 - 1
L2:
	call index_mod_key
	mov al, plainText2[esi]
	call encrypt_char
	mov encryptedText2[esi], al
	inc esi
	loop L2

	mov edx, OFFSET msgPlain
	call WriteString
	mov edx, OFFSET plainText2
	call WriteString
	call Crlf
	mov edx, OFFSET msgEncrypted
	call WriteString
	mov edx, OFFSET encryptedText2
	call WriteString
	call Crlf

	mov edx, OFFSET msgPlain
	call WriteString
	mov edx, OFFSET plainText1
	call WriteString
	call Crlf
	mov edx, OFFSET msgEncrypted
	call WriteString
	mov edx, OFFSET encryptedText1
	call WriteString
	call Crlf

	exit
main ENDP


encrypt_char PROC USES ecx
	movzx eax, bl
	mov bl, 26
	div bl
	mov bl, ah

	cmp bl, 0
	jge rot_left
	jmp rot_right

rot_left:
	mov cl, bl
	rol al, cl
	jmp return

rot_right:
	neg bl
	mov cl, bl
	ror al, cl

return:
	ret
encrypt_char ENDP


decrypt_char PROC
	neg bl
	call encrypt_char
decrypt_char ENDP

index_mod_key PROC USES eax
	mov eax, esi
	mov edx, 0
	mov ebx, keySize
	div ebx
	mov bl, key[edx]
	ret
index_mod_key ENDP

END main