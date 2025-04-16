title MultArray Procedure      (AsmMultArray.asm)


.586
.model flat,C

AsmMultArray PROTO,
	srchVal:DWORD, arrayPtr:PTR DWORD, arraySize:DWORD

.code
;-----------------------------------------------
AsmMultArray PROC USES edi,
	mval:DWORD, arrayPtr:PTR DWORD, arraySize:DWORD
;
; Multiplies each element of an array by mval.
;-----------------------------------------------
 	mov	ebx,mval    		; multiplier
 	mov	ecx,arraySize      	; number of items
 	mov	edi,arrayPtr     	; pointer to array
 	
;L1:
    ;mov	eax,ebx			    ; get multiplier
	;imul	eax, DWORD PTR[edi]	; multiply by array val
	;mov	DWORD PTR[edi],eax	; store in the array
	;add	edi,TYPE DWORD
	;loop	L1

L1:
    mov  eax, ebx               ; get multiplier
    imul eax, DWORD PTR [edi]   ; multiply by array val
    mov  DWORD PTR[edi], eax    ; store in the array
    add  edi, TYPE DWORD        ; advance to next value in array
    dec  ecx                    ; eliminate a lot of loop overhead
    jnz  L1
	
	ret   
AsmMultArray ENDP

END

