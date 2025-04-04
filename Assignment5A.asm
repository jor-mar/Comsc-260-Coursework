TITLE Simple Addition (Assignment5A.asm)
; This program:
; "clears the screen,
; locates the cursor near the middle of the screen,
; prompts the user for two integers,
; and displays their sum"
; Written by Jordan Marcelo

INCLUDE Irvine32.inc

.data
firstInteger SDWORD ?		; Instantiates a variable to save the first user response
secondInteger SDWORD ?		; Instantiates a variable to save the second user response
prompt1 BYTE "Enter 1st 32-bit integer: ",0		; The message that will prompt the user to enter their first integer
prompt1Size = $ - prompt1		; Gets the size of prompt1 so that centering is meaningful
prompt2 BYTE "Enter 2nd 32-bit integer: ",0		; The message that will prompt the user to enter their second integer
prompt2Size = $ - prompt2		; Gets the size of prompt2 so that centering is meaningful

.code
main PROC
	call Clrscr		; Clears the screen

	call GetMaxXY		; Gets max window resolution
	shr al, 1		; Halves each screen distance to get central coordinates
	shr dl, 1		; Halves each screen distance to get central coordinates
	sub dl, prompt1Size/2		; Decreases from exact center column by using half of the length of prompt1 so that it appears exactly in the middle
	dec eax			; Moves the cursor one above the center
	mov dh, al		; Moves desired row number to row parameter for Gotoxy
	call Gotoxy		; Moves cursor to aforementioned central coordinates

	mov edx, OFFSET prompt1		; Moves prompt 1 string to edx register to be displayed
	call WriteString		; Displays prompt 1 via edx register
	xor eax, eax		; Clears eax to be used for int reading
	call ReadInt		; Gathers the user's input for a 32-bit signed integer, saves it to eax
	mov firstInteger, eax		; Saves user's input in firstInteger variable

	call GetMaxXY		; Gets max window resolution
	shr al, 1		; Halves each screen distance to get central coordinates
	shr dl, 1		; Halves each screen distance to get central coordinates
	sub dl, prompt2Size/2		; Decreases from exact center column by using half of the length of prompt2 so that it appears exactly in the middle
	mov dh, al		; Moves desired row number to row parameter for Gotoxy
	call Gotoxy		; Moves cursor to central coordinates

	mov edx, OFFSET prompt2		; Moves prompt 2 string to edx register to be displayed
	call WriteString		; Displays prompt 2 via edx register
	xor eax, eax		; Clears eax to be used for int reading
	call readInt		; Gathers the user's input for a second 32-bit signed integer, saves it to eax
	mov secondInteger, eax		; Saves user's input in secondInteger variable

	call GetMaxXY		; Gets max window resolution
	shr al, 1		; Halves each screen distance to get central coordinates
	shr dl, 1		; Halves each screen distance to get central coordinates
	inc eax			; Move cursor one row down from previous print statement
	mov dh, al		; Moves desired row number to row parameter for Gotoxy
	call Gotoxy		; Moves cursor to aforementioned central coordinates

	mov eax, firstInteger		; Moves user's first saved 32-bit signed integer to eax to be added
	add eax, secondInteger		; Adds user's second saved 32-bit signed integer to their first saved 32-bit signed integer, stored in eax
	call WriteDec		; Displays the result of that addition (stored in eax) as a decimal number

	exit
main ENDP
END main