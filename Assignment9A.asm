TITLE Str_cpyN (Assignment9A.asm)
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
; Declare test cases and empty target strings
string1 BYTE "This will be cut off",0
string2 BYTE SIZEOF string1 DUP (?)
string3 BYTE "The quick brown fox jumps over the lazy dog",0
string4 BYTE SIZEOF string3 DUP (?)

.code
; Declare prototype procedure to allow invoke calls
Str_copyN PROTO,
	source:PTR BYTE,
	target:PTR BYTE,
	maxChars:DWORD

main PROC
	; Display original strings
	mov edx, OFFSET string1
	call WriteString
	call Crlf
	mov edx, OFFSET string3
	call WriteString
	call Crlf

	; copy strings with limits
	INVOKE Str_copyN, ADDR string1, ADDR string2, 3
	INVOKE Str_copyN, ADDR string3, ADDR string4, 9

	; Display results
	mov edx, OFFSET string2
	call WriteString
	call Crlf
	mov edx, OFFSET string4
	call WriteString
	call Crlf

	exit
main ENDP

;---------------------------------------------------------
Str_copyN PROC USES eax ecx esi edi,
	source:PTR BYTE,		; string to copy to target
	target:PTR BYTE,		; string to store result of copying
	maxChars:DWORD			; max characters to copy
;
; Copies at most maxChars characters from source to target
; or copies target if maxChars >= target
;---------------------------------------------------------
	invoke Str_length, source; Get source length
	cmp eax, maxChars		; source length <= maxChars?
	jb copy					; yes: start copying maxChars characters
	mov eax, maxChars		; no: use source length instead
copy:
	mov ecx, eax			; start counter with length of source
	mov esi, source			; move source array address to esi
	mov edi, target			; move destination array address to edi
	cld						; direction: forward
	rep movsb				; copy the characters
	mov BYTE PTR [edi], 0   ; add null terminator
	ret
Str_copyN ENDP

END main