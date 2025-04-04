TITLE Random Screen Locations (Assignment5B.asm)
; This program displays a single character at 100 random screen locations, using a timing delay of 100 milliseconds.
; Written by Jordan Marcelo

INCLUDE Irvine32.inc

N_TIMES EQU 100     ; The number of times this program will loop
TIME_INTERVAL EQU 100       ; The delay (ms) between each loop of the program
msg = 'X'       ; The character to be printed on random parts of the screen

.data
maxX BYTE ?     ; Instantiates a variable that will be the number of rows on window
maxY BYTE ?     ; Instantiates a variable that will be the number of columns on window
randX BYTE ?        ; Instantiates a variable that will be a random integer from [0, maxX]
randY BYTE ?        ;  Instantiates a variable that will be a random integer from [0, maxY]

.code
main PROC
    call Randomize      ; Sets random seed based on time of day, allows RandomRange to work

    call GetMaxXY       ; Gathers max rows and columns on window, exports them to al and dl
    mov maxX, al        ; Saves max rows on al to variable maxX
    mov maxY, dl        ; Saves max columns on dl to variable maxY

    mov ecx, N_TIMES        ; Sets ecx (natural) loop parameter to number of times L1 will loop

L1:
    mov eax, TIME_INTERVAL      ; Moves TIME_INTERVAL to eax so that Delay will use it as a parameter
    call Delay      ; Waits TIME_INTERVAL ms, since that is the parameter in eax

    movzx eax, maxX     ; zero-extends 8-bit maxX and sets it in eax so that RandomRange can use it as an upper bound
    call RandomRange    ; Outputs a random integer from [0, maxX] in eax
    mov randX, al       ; Saves the random integer from [0, maxX] (1 byte) as randX, happens once per loop

    movzx eax, maxY     ; zero-extends 8-bit maxY and sets it in eax so that RandomRange can use it as an upper bound
    call RandomRange    ; Outputs a random integer from [0, maxX] in eax
    mov randY, al       ; Saves the random integer from [0, maxX] (1 byte) as randX, happens once per loop

    ; Set screen coordinates
    mov dh, randX       ; Sets aforementioned random, valid x-coordinate parameter for Gotoxy call
    mov dl, randY       ; Sets aforementioned random, valid y-coordinate parameter for Gotoxy call
    call Gotoxy     ; Moves cursor to the aforementioned random x and y coordinates

    mov al, msg     ; Moves desired letter in msg to al part of register to be used in WriteChar call
    call WriteChar      ; Displays the character in al part of register, which is msg

    loop L1     ; Jumps to L1 while decrementing ecx until ecx is 0, ie. jumps to L1 (N_TIMES - 1) times.

    exit
main ENDP
END main
