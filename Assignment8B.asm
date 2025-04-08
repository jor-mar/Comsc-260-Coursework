TITLE Chess Board (Assignment8B.asm)
; Jordan Marcelo

COMMENT !
Write a program that draws an 8 X 8 chess board with alternating grey and white squares.
You can use the SetTextColor and Gotoxy procedures from the Irvine32 library.
Avoid the use of global variables, and use declared parameters in all procedures.
Use short procedures that are focused on a single task.
!

INCLUDE Irvine32.inc

.code

; Declare prototype procedures so that parameters can be invoked into stacks
DrawChessBoard PROTO,
	X:BYTE,
	Y:BYTE

DrawRow PROTO,
	startingColor:SBYTE,
	startingX:BYTE,
	startingY:BYTE

main PROC
	; Get close to center of screen positions by halving max X and Y values, then
	; subtract half the chessboard dimensions so that the chessboard is relatively centered
	call GetMaxXY
	shr dl, 1
	sub dl, 4
	shr dh, 1
	add dh, 4
	invoke DrawChessBoard, dl, dh	; call chessboard drawing function with aforementioned calculated central coordinates
	call Crlf						; line skip for vanity
	exit
main ENDP

;-----------------------------------------------------
DrawChessBoard PROC USES eax ebx ecx edx,
	X:BYTE,
	Y:BYTE
; Draw a chessboard at desired coordinates
; Precondition:
; X = x-coordinate where board will start being drawn from left to right
; Y = y-coordinate where board will start being drawn from top to bottom
; Postcondition:
; Chessboard drawn at desired coordinates
; Returns: nothing
;-----------------------------------------------------

	; start loop to create chessboard
	; each loop draws 1 row that begins with gray then 1 row that begins with white
	; for 8 total chessboard rows in 4 loops
	mov ecx, 4
	mov dh, Y
boardLoop:
	invoke DrawRow, 0, X, dh		; draw a row beginning with a gray square at line start
	inc dh							; advance cursor downward to next row
	invoke DrawRow, 1, X, dh		; draw a row beginning with a white square at line start
	inc dh							; advance cursor downward to next row
	loop boardLoop					; repeat drawing alternating rows until 8 are fully drawn

	mov eax, white
	call SetTextColor				; reset text color to white for future applications
	ret								; return to main proc
DrawChessBoard ENDP

;-----------------------------------------------------
DrawRow PROC USES ecx,
	startingColor:SBYTE,
	startingX:BYTE,
	startingY:BYTE
; Draw a chessboard row at desired coordinates
; startingColor = 0 or 1, where 1 is white and 0 is gray; determines the color
;	of the first square in the drawn row
; Precondition:
; startingX = x-coordinate where board will start being drawn from left to right
; startingY = y-coordinate where board will start being drawn from top to bottom
; Postcondition:
; Chessboard row drawn at desired coordinates
; Returns: nothing
;-----------------------------------------------------

	; declare a local square string to display, using ASCII code
    LOCAL square[2]:BYTE			; add 2-capacity byte array
    mov square[0], 219				; add square character (219 in ASCII)
    mov square[1], 0				; add null-termination character

	; create 8 squares of alternating colors in the row
	mov ecx, 8						; bound loop to 8 loops
	mov dl, startingX				; set initial X position as WriteString parameter
	mov dh, startingY				; set initial Y position as WriteString parameter
	mov bl, startingColor			; use startingColor to determine beginning row color
rowLoop:
	cmp bl, 0						; if bl is 0,
	je gray_color					; set text color to gray
	mov eax, white					; otherwise set it to white
	jmp display						; call SetTextColor function, advance loop
gray_color:
	mov eax, gray
display:
	call SetTextColor				; set text color to previously determined color

	push edx						; save edx (current cursor coordinates)
	call GoToXY						; set cursor at desired column in row coordinate (current cursor coordinates)
	lea edx, square
	call WriteString				; display a square of the chosen color at the cursor position
	pop edx							; restore edx (current cursor coordinates)

	inc dl							; increment dl so next square is in next column
	xor bl, 1						; flip bl bit so color alternates via above binary/switch comparison
	loop rowLoop					; loop so that 8 total squares are created in this row
	ret								; return to caller DrawChessBoard
DrawRow ENDP
END main