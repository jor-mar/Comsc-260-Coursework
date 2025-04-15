title SumArrays Procedure      (AsmSumThreeArrays.asm)


.586
.model flat,C

AsmSumThreeArrays PROTO,
	array1: PTR DWORD, array2: PTR DWORD, array3: PTR DWORD, arraySize: DWORD

.code
;-----------------------------------------------
AsmSumThreeArrays PROC USES ebx ecx edi,
	array1: PTR DWORD, array2: PTR DWORD, array3: PTR DWORD, arraySize: DWORD
;
; Adds corresponding elements of each array to each other,
; stores results in array1.
; array2 and array3 must be at least same length as array1.
;-----------------------------------------------
	mov ecx, arraySize						; use array size as counter
	xor ebx, ebx							; clear ebx to be used as 0-based, type-specific index
L1:											; accessing arr[ebx/4] via base-index-scale displacement
	mov edi, array2							; load array2
	mov eax, DWORD PTR [edi + ebx]			; eax = array2[ebx/4]
	mov edi, array3							; load array3
	add eax, DWORD PTR [edi + ebx]			; eax = array2[ebx/4] + array3[ebx/4]
	mov edi, array1							; load array1
	add DWORD PTR [edi + ebx], eax			; store sum: array1[ebx/4] += eax
	add ebx, TYPE DWORD						; increment index to next element
	dec ecx
	jnz L1									; loop back to L1 for all elements in array1

	ret
AsmSumThreeArrays ENDP

END