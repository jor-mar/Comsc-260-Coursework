TITLE Find Largest Procedure (Assignment8A.asm)
; Jordan Marcelo

COMMENT !
Create procedure named FindLargest that receives two parameters:
A pointer to a signed doubleword array
A count of the array’s length
The procedure must return the value of the largest array member in EAX.
Use the PROC directive with a parameter list when declaring the procedure.
Reserve all registers (except EAX) that are modified by the procedure.
Write a test program that calls FindLargest and passes three different arrays of different lengths.
Be sure to include negative values in your arrays. Create a PROTO declaration for your FindLargest Procedure.
!

INCLUDE Irvine32.inc

.data
; declare test case arrays
arr1 SDWORD -15, 20, 80, 30, 0, -90, 100, 15000, -50
arr2 SDWORD -300, 0
arr3 SDWORD -2

.code

FindLargest PROTO,					; create a proto signature for FindLargest to invoke call with parameters
	arrAddr:PTR DWORD,
	arrLength:DWORD

main PROC
	; call FindLargest on arr1
	invoke FindLargest, ADDR arr1, LENGTHOF arr1
	call WriteInt
	call Crlf

	; call FindLargest on arr2
	invoke FindLargest, ADDR arr2, LENGTHOF arr2
	call WriteInt
	call Crlf

	; call FindLargest on arr3
	invoke FindLargest, ADDR arr3, LENGTHOF arr3
	call WriteInt
	exit
main ENDP

;-----------------------------------------------------
FindLargest PROC USES ecx edx esi,
	arrAddr: PTR DWORD,
	arrLength: DWORD
; Find the largest element in the passed in array
; Precondition:
; arrAddr = address of the array
; arrLength = length of the array
; Postcondition:
; eax stores largest element in the array
; Returns: largest element in array
;-----------------------------------------------------

	cmp arrLength, 0
	jz return						; return if array length is 0, indicating no array to be found

	mov ecx, arrLength				; bound loop through entire array with ecx
	mov esi, arrAddr				; move array address to esi to refer to individual elements
	mov eax, [esi]					; assume first element is largest, store it in eax
	add esi, TYPE SDWORD			; move to next element (starting loop on 2nd element)
	dec ecx							; decrease number of loops left through array (starting loop on 2nd element)
	jz return						; if ecx = 0 ie. no more loops left, zero flag is set -> return if zf

	; loop through array, comparing each element to largest
	; store element in eax if it is greater than largest at eax
L1:
	mov edx, [esi]					; mov element to edx for comparison
	add esi, TYPE SDWORD			; increment esi to next element address for next loop
	cmp edx, eax
	jge new_max						; determine if current element is greater than max element, jump to new_max if so
	loop L1							; repeat loop or exit if done
	jmp return

new_max:							; set current element as the new max value element by moving it to eax
	mov eax, edx					; if determined above that it is greater than the old max value element
	loop L1							; repeat loop or exit if done

return:								; return to caller
	ret
FindLargest ENDP
END main