TITLE STR_concat (Assignment9B.asm)
; Jordan Marcelo

COMMENT !
The procedure should concatenate a source string to the end of a target string.
Sufficient space must exist in the target string to accommodate the two strings.
!

INCLUDE Irvine32.inc

.data
; declare test cases, one terminated by 0s and one terminated by unallocated memory
targetStr BYTE "ABCDE", 4 DUP(0)
sourceStr BYTE "FGH", 0
targetStr1 BYTE "Why did the chicken cross the road? ", 26 DUP(?)
sourceStr1 BYTE "To get to the other side.", 0

.code
; declare prototype procedure to allow invoking the Str_concat procedure
Str_concat PROTO,
	target:PTR BYTE,
	source:PTR BYTE

main PROC
	; display targetStr and sourceStr
	mov edx, OFFSET targetStr
	call WriteString
	call Crlf
	mov edx, OFFSET sourceStr
	call WriteString
	call Crlf

	; concatenate sourceStr to the end of targetStr and display results
	INVOKE Str_concat, OFFSET targetStr,  OFFSET sourceStr
	mov edx, OFFSET targetStr
	call WriteString
	call Crlf

	call Crlf

	; display targetStr1 and sourceStr1
	mov edx, OFFSET targetStr1
	call WriteString
	call Crlf
	mov edx, OFFSET sourceStr1
	call WriteString
	call Crlf

	; concatenate sourceStr1 to the end of targetStr1 and display results
	INVOKE Str_concat, OFFSET targetStr1,  OFFSET sourceStr1
	mov edx, OFFSET targetStr1
	call WriteString
	call Crlf
	exit
main ENDP

;---------------------------------------------------------
Str_concat PROC USES eax ecx edi esi,
	target:PTR BYTE,	; string to be concatenated to
	source:PTR BYTE		; string to concatenate to target
;
; Concatenates source to the end of target.
; Requires target to have enough space to fit source after it.
;---------------------------------------------------------

	mov esi, source				; add source address to esi
	mov edi, target				; add target address to edi

	invoke Str_length, target	; find length of target
	add edi, eax				; align edi to end of target
	
	invoke Str_length, source	; find length of source
	mov ecx, eax				; set rep count to length of source
	cld							; direction: forward
	rep movsb					; copy source to end of target
	ret							; return to caller
Str_concat ENDP
END main