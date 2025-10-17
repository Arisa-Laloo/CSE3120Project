INCLUDE Irvine32.inc

.data 
promp BYTE "Guess a number between 1 and 50", 0
promptHigh BYTE "Too High!", 0
promptLow BYTE "Too Low!", 0
promptCorrect BYTE "Correct", 0
newline BYTE 13,10,0

target DWORD ?
guess DWORD ?
attempts DWORD 0

.code
main PROC 
call Clrscr
call Randomize

mov eax, 50		 ; upper bound
call RandomRange ; 0-49
inc eax			 ; shift range to 1 - 50
mov target, eax
call WriteDec	 ; print decimal value in eax 
call Crlf

exit
main ENDP
END main