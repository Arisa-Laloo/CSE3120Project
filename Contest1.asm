INCLUDE Irvine32.inc

.data 
promptLevel BYTE "Choose the difficulty level. 1 = Easy (1-50), 2 = Medium (1-100), 3 = Hard (1-150) ", 0
promptGuess BYTE "Enter you guess: ", 0
promptHigh BYTE "Too High!", 0
promptLow BYTE "Too Low!", 0
promptCorrect BYTE "You Win!", 0
promptReplay BYTE "Would you like to play again? (Y/N): ", 0
dispAttempts BYTE "Number of Attempts"
newline BYTE 13,10,0

level DWORD ?
target DWORD ?
guess DWORD ?
attempts DWORD 0
replayAns BYTE 4 DUP(0)

.code
main PROC 
call Clrscr
call Randomize

;method to ask for level preference
mov edx, OFFSET promptLevel  ; output string to ask for difficulty level
call WriteString
call ReadDec                 
mov level, eax               ; read and store input
cmp level, 1
je Easy                      ; jump to easy method if level was 1
cmp level, 2                 
je Medium                    ; jump to medium method if level 2
jmp Hard                     ; else jump to hard 


;methods for setting the range of values based on difficulty level
;each method moves the max possible vlue to eax then jumps to the Range method to set the range of values 
Easy:
	
	mov eax, 50              ; 0-50 range for easy
	jmp Range	

Medium:
	mov eax, 100             ; 0-100 range for medium
	jmp Range

Hard:
	mov eax, 150			 ; 0-150 range for hard
	jmp Range

Range:
	call RandomRange ; 0-eax
	inc eax			 ; shift range to 1 - eax
	mov target, eax
	call WriteDec	 ; print decimal value of target 
	call Crlf

GameLoop:
	inc attempts                 
	mov edx, OFFSET promptGuess  ; prompt player to enter their guess
	call WriteString              
	call Crlf
	call ReadDec                  
	mov guess, eax               ; read and store players guess

	cmp eax, target              ;compare the guess to the target
	jl TooLow					 ; jump to too low method if it's lower
	je Correct					 ; jump to the correct method if it is equal
	jg TooHigh					 ; jump to the higher method if it is higher

TooHigh:
	mov edx, OFFSET promptHigh	 ; print that guess was too high and prompt for another guess
	call WriteString
	call Crlf
	jmp GameLoop				 ; run throught game loop again

TooLow:
	mov edx, OFFSET promptLow    ; print that guess was too lowand prompt for another guess
	call WriteString 
	call Crlf
	jmp GameLoop				  ; return to the game loop

Correct:
	mov edx, OFFSET promptCorrect ; tell user answer in correct
	call WriteString
	call Crlf

	; display attempts
	mov edx, OFFSET dispAttempts  ;display the number of attempts
	call WriteString 
	mov eax, attempts 
	call WriteDec
	call Crlf


main ENDP

;loop to play again
Replay PROC
	mov edx, OFFSET promptReplay  ;ask player if they want to play again
	call WriteString 

	; read and compare the input string
	mov edx, OFFSET replayAns
	mov ecx, SIZEOF replayAns
	call ReadString               
	mov al, replayAns

	; if answer was Y or y, return to main
	cmp al, 'Y'
	je main
	cmp al, 'y'
	je main 
	exit
Replay ENDP
END main