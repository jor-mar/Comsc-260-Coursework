TITLE Boolean Calculator (Assignment6.asm)
; This program evaluates user's choice of 5 simple boolean statements.
; Jordan Marcelo

INCLUDE Irvine32.inc

.data
; array giving directions
initialPrompt BYTE "Please select an option below to evaluate:",0
; array of given boolean statements
prompts BYTE "x AND y",0
		BYTE "x OR y",0
		BYTE "NOT x",0
		BYTE "x XOR y",0
		BYTE "Exit the program",0
; array of boolean statement offsets for easier access
prompt_offsets DWORD OFFSET prompts,
			  OFFSET prompts + 8,
			  OFFSET prompts + 15,
			  OFFSET prompts + 21,
			  OFFSET prompts + 29
period BYTE ". ",0		; byte that will separate listed numbers and boolean statements
affirmation BYTE "You chose: ",0		; byte that will tell the user what statement they chose
hexPrompt BYTE "Please input one hexadecimal integer, ",0		; message asking for one hex int to be input
; array of the variables we will be using
colon_variables BYTE "x:",0
				BYTE "y:",0
; messages summarizing the result of the user's desired operation
resultMessage1 BYTE "The result of your ",0
resultMessage2 BYTE " operation is: ", 0

userInput DWORD ?		; storage for the user's input


.code
main PROC
	call Clrscr		; clears console so it is ripe for usage
ask:
	call ChooseProcedure ; calls the ChooseProcedure code
	jmp ask		; infinitely loops to calling the ChooseProcedure code
	exit		; technically unreachable, but good to have just in case
main ENDP

; starts ChooseProcedure, generating push and pop instructions
; for the registers that will be modified,
; so that after the procedure, they are as they were before it
; keeps eax, which is the result of the user's operation, just in case its usage is desired in future use
ChooseProcedure PROC USES ecx edx esi ebx
	; writes the initial directive asking the user to choose a statement to evaluate
	mov edx, offset initialPrompt		; moves the initial prompt to edx to be displayed in the next line
	call WriteString		; writes the initial prompt in the console
	call Crlf		; move the cursor down two lines to prepare for what will be displayed next
	call Crlf

	; prepares to loop through the options and display each one in the following format:
	; 1. x AND y
	; 2. ...
	; ...
	mov esi, OFFSET prompt_offsets		; keeps address of first prompt element in esi
	mov ecx, LENGTHOF prompt_offsets		; ecx = # of elements in prompts
L1:
	mov eax, LENGTHOF prompt_offsets		; eax = # of elements in prompts
	sub eax, ecx		; eax = # of elements in prompts - number of loops not completed
	inc eax		; eax += 1, ie. starts on 1 then goes to 2 when ecx has been decremented for second loop, etc.
	call WriteDec		; writes decimal form of the loop that we are on (1,2,...), which was stored in eax
	mov edx, OFFSET period		; puts a period and space after the loop number
	call WriteString		; displays the aforementioned period and space
	mov edx, DWORD PTR [esi]		; gets the current boolean statement (we are looping through them)
	call WriteString		; displays the current statement
	call Crlf		; moves the cursor down a line to prepare for the next loop
	; since we are using esi to loop through prompt_offsets, we are increasing it by TYPE prompt_offsets
	; so that we can use a loop through prompt_offsets to get the strings in prompts
	add esi, TYPE prompt_offsets
	loop L1		; jumps to L1, decrementing ecx

	call Crlf

Read_Choice:
	call ReadDec		; gathers decimal input of user, stored in eax
	dec eax		; decrements decimal input of user to be used as an index in the jump table

	cmp eax, 0
	jb Read_Choice		; jumps back to the ReadDec procedure if the entered number is negative, ie. eax < 0
	cmp eax, LENGTHOF jumpTable - 1
	ja Read_Choice		; jumps back to the ReadDec procedure if the entered number is above # of options, ie. eax > 4

	; writes confirmation message telling user what statement they chose
	mov edx, OFFSET affirmation
	call WriteString
	mov edx, DWORD PTR [prompt_offsets + eax * TYPE prompt_offsets]
	call WriteString
	push edx		; saves statement they chose for later
	call Crlf

	; use jump table as switch conditional to evaluate chosen boolean statement
	jmp [jumpTable + eax * TYPE jumpTable]

	jumpTable DWORD OFFSET AND_op,  ; Entry 1: x AND y
					OFFSET OR_op,   ; Entry 2: x OR y
					OFFSET NOT_op,  ; Entry 3: NOT x
					OFFSET XOR_op,  ; Entry 4: x XOR y
					OFFSET Exit_Program  ; Entry 5: Exit

; 1. x AND y
AND_op:
	call Get_Two_Vars		; gathers 2 variables, x in userInput and y in eax
	AND eax, userInput		; evaluates the chosen boolean statement
	jmp ReturnChooseProc		; prints out results and ends procedure (returns to main PROC)

; 2. x OR y
OR_op:
	call Get_Two_Vars		; same as AND_op, just with different operation
	OR eax, userInput
	jmp ReturnChooseProc

; 3. NOT x
NOT_op:
	; creates hex collector with prompt that incorporates variable x, stores input in eax
	mov ebx, OFFSET colon_variables
	call Hex_Prompt
	NOT eax		; evaluates the chosen boolean statement
	jmp ReturnChooseProc		; prints out results and ends procedure (returns to main PROC)

; 4. x XOR y
XOR_op:
	call Get_Two_Vars		; same as AND_op, just with different operation
	XOR eax, userInput
	jmp ReturnChooseProc

; 5. Exit the program
Exit_Program:
	exit		; exits the program if 5 is chosen

; prints out summary of operations, including chosen operation and its result
ReturnChooseProc:
	mov edx, OFFSET resultMessage1		; displays first part of results summary message
	call WriteString
	pop edx		; displays string of chosen boolean statement from earlier "push edx"
	call WriteString
	mov edx, OFFSET resultMessage2		; displays second part of results summary message
	call WriteString
	call Crlf
	call WriteHex		; displays actual result of boolean operation
	call Crlf		; moves cursor down 3 lines in preparation for future displays
	call Crlf
	call Crlf
	ret		; returns to main PROC, or whichever procedure called it in the first place
ChooseProcedure ENDP

; gathers two hexadecimal integers from user input:
; the first is stored in userInput,
; the second is stored in eax.
; additionally, prompts the user for these entries, with the variable name from colon_variables
Get_Two_Vars PROC
	mov ebx, OFFSET colon_variables
	call Hex_Prompt		; creates hex collector with prompt that incorporates variable x, stores input in eax
	mov userInput, eax		; saves first input in userInput
	add ebx, 3		; increases ebx address to address of second variable name/declaration "y:"
	call Hex_Prompt		; creates hex collector with prompt that incorporates variable y, stores in eax
	ret		; returns to where it was called
Get_Two_Vars ENDP

; prompts the user for a hexadecimal integer
; saves it to eax
; incorporates variable name from ebx address in its prompting
Hex_Prompt PROC
	mov edx, OFFSET hexPrompt
	call WriteString		; displays the prompt asking for a hex integer
	mov edx, ebx
	call WriteString		; displays the variable name in the prompt
	call Crlf
	call ReadHex		; reads the inputted hex number and saves it into eax
	ret
Hex_Prompt ENDP
END main