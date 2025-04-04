TITLE Simple Addition (Assignment5A2.asm)
; This program:
; "clears the screen,
; locates the cursor near the middle of the screen,
; prompts the user for two integers,
; and displays their sum"
; Written by Jordan Marcelo

INCLUDE Irvine32.inc

.data
firstInteger SDWORD ?		; Instantiates a variable to save the first user response
prompt1 BYTE "Enter 1st 32-bit integer: ",0		; The message that will prompt the user to enter their first integer
prompt1Size = $ - prompt1		; Gets the size of prompt1 so that centering is meaningful
prompt2 BYTE "Enter 2nd 32-bit integer: ",0		; The message that will prompt the user to enter their second integer
; prompt2Size = $ - prompt2		; Gets the size of prompt2 so that centering is meaningful
centerX BYTE ?
centerY BYTE ?

.code
main PROC
	call Clrscr		; Clears the screen
	call GetMaxXY		; Gets max window resolution
	shr al, 1		; Halves each screen distance to get central coordinates
	shr dl, 1		; Halves each screen distance to get central coordinates
	mov centerX, dl		; Saves the central X coordinate
	mov centerY, al		; Saves the central Y coordinate

	mov dh, al		; Moves central Y coordinate to Y parameter for Gotoxy
	sub dh, 1		; Sets desired cursor position one above the center
	sub dl, prompt1Size / 2 + 1		; Decreases from exact center column by using half of the length of prompt1 so that prompt1 appears exactly in the middle
	call Gotoxy		; Moves cursor to modified central coordinates

	push edx
	mov edx, OFFSET prompt1		; Moves prompt 1 string to edx register to be displayed
	call WriteString		; Displays prompt 1 via edx register
	call ReadInt		; Gathers the user's input for a 32-bit signed integer in eax
	mov firstInteger, eax		; Saves user's input in firstInteger variable
	pop edx

	;mov dl, centerX				; Moves central X coordinate to parameter for Gotoxy
	;mov dh, centerY		; Moves central Y coordinate to parameter for Gotoxy
	;sub dl, prompt2Size/2		; Decreases from exact center column by using half of the length of prompt2 so that prompt2 appears exactly in the middle
	add dh, 1
	call Gotoxy		; Moves cursor to modified central coordinates

	push edx
	mov edx, OFFSET prompt2		; Moves prompt 2 string to edx register to be displayed
	call WriteString		; Displays prompt 2 via edx register
	call readInt		; Gathers the user's input for a second 32-bit signed integer, saves it to eax
	pop edx

	;mov dl, centerX		; Moves desired column number to column parameter for Gotoxy
	;mov dh, centerY		; Moves desired row number to row parameter for Gotoxy
	add dl, prompt1Size / 2 + 1
	add dh, 1		; Set desires cursor position one row below previous string
	call Gotoxy		; Moves cursor to modified central coordinates

	add eax, firstInteger		; Adds user's first saved 32-bit signed integer to their second saved 32-bit signed integer, stored in eax
	call WriteDec		; Displays the result of that addition (stored in eax) as a decimal number

	exit
main ENDP
END main