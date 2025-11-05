INCLUDE Irvine32.inc

.data 
promptLevel BYTE "Choose the difficulty level. 1 = Easy (0-50), 2 = Medium (0-100), 3 = Hard (0-150)", 0
promptGuess BYTE "Enter you guess: ", 0
promptHigh BYTE "Too High!", 0
promptLow BYTE "Too Low!", 0
promptCorrect BYTE "Correct", 0
newline BYTE 13,10,0

level DWORD ?
target DWORD ?
guess DWORD ?
attempts DWORD 0

.code
main PROC 
call Clrscr
call Randomize

;Ask for level preference
mov edx, OFFSET promptLevel
call WriteString
call ReadDec
mov level, eax
cmp level, 1
je Easy
cmp level, 2
je Medium
jmp Hard

Easy:
	mov eax, 50
	jmp Range

Medium:
	mov eax, 100
	jmp Range

Hard:
	mov eax, 150 
	jmp Range

Range:
	call RandomRange ; 0-eax
	inc eax			 ; shift range to 1 - 50
	mov target, eax
	call WriteDec	 ; print decimal value of target 
	call Crlf

GameLoop:
	inc attempts
	mov edx, OFFSET promptGuess
	call WriteString
	call Crlf
	call ReadDec
	mov guess, eax

	cmp eax, target
	jb TooLow
	je Correct
	ja TooHigh 
	


TooHigh:
	mov edx, OFFSET promptHigh
	call WriteString
	call Crlf
	jmp GameLoop

TooLow:
	mov edx, OFFSET promptLow
	call WriteString 
	call Crlf
	jmp GameLoop


Correct:
	mov edx, OFFSET promptCorrect
	call WriteString
	call Crlf
	mov eax, attempts
	call WriteDec
	call Crlf



exit
main ENDP
END main