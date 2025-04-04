TITLE Simple Addition (Assignment5A3.asm)
; This program:
; "clears the screen,
; locates the cursor near the middle of the screen,
; prompts the user for two integers,
; and displays their sum"
; Written by Jordan Marcelo

INCLUDE Irvine32.inc

.data
firstInteger SDWORD ?					; Instantiates a variable to save the first user response
prompt1 BYTE "Enter 1st integer: ",0	; The message that will prompt the user to enter their first integer
prompt1Size = $ - prompt1				; Gets the size of prompt1 for centering
prompt2 BYTE "Enter 2nd integer: ",0	; The message that will prompt the user to enter their second integer
										; No need to get size of prompt2 because it is the same size as prompt1
										; No need to instantiate second integer because it is collected in eax where we can add to it
.code
main PROC
	call Clrscr						; Clears the screen
	call GetMaxXY					; Gets max window resolution
	shr al, 1						; Halves max Y coordinate to get central Y coordinate
	shr dl, 1						; Halves max X coordinate to get central X coordinate
									; The central X coordinate is already at X coordinate parameter for GoToXY
	mov dh, al						; Moves central Y coordinate to Y coordinate parameter for GoToXY
	dec dh							; Sets desired cursor position vertically one above the center
	sub dl, prompt1Size / 2 + 1		; Sets X coordinate left of center column by half length of prompt1 so prompt1 is almost centered
	call GoToXY						; Moves cursor to modified central coordinates

	push dx							; Saves modified central coordinates in dx register to stack
	mov edx, OFFSET prompt1			; Moves prompt 1 string to edx register to be displayed
	call WriteString				; Displays prompt 1 via edx register
	pop dx							; Resets dx register to modified central coordinates in stack
	call ReadInt					; Gathers the user's input for a 32-bit signed integer in eax
	mov firstInteger, eax			; Saves user's input in firstInteger variable

	inc dh							; Sets desired cursor Y coordinate from earlier exactly at center, one row below previous string
	call GoToXY						; Moves cursor to modified central coordinates

	push dx							; Saves modified central coordinates in dx register to stack
	mov edx, OFFSET prompt2			; Moves prompt 2 string to edx register to be displayed
	call WriteString				; Displays prompt 2 via edx register
	pop dx							; Resets dx register to modified central coordinates in stack
	call ReadInt					; Gathers the user's input for a second 32-bit signed integer, saves it to eax

	add dl, prompt1Size / 2 + 1		; Put desired cursor column back in true center by reversing prior modification
	inc dh							; Set desired cursor position one row below previous string
	call GoToXY						; Moves cursor to modified central coordinates

	add eax, firstInteger			; Adds user's first saved integer to their second integer, stored in eax
	call WriteDec					; Displays the result of that addition (stored in eax) as a decimal number
	exit							; Exits the program
main ENDP
END main