.ORIG x3000
;instructions
;get user input string
LEA R1, array
LD R2, SUB_GET_STRING_3200
JSRR R2
LEA R0, array
PUTS

LEA R0, not_palindrome_string

;check if user input string is palindrome
LEA R1, array
LD R2, SUB_IS_PALINDROME_3400
JSRR R2
ADD R4, R4, #0
BRz NOT_PALINDROME

LEA R0, palindrome_string

NOT_PALINDROME
PUTS

HALT
;data
SUB_GET_STRING_3200 .FILL x3200
SUB_IS_PALINDROME_3400 .FILL x3400
array .BLKW #100
newline .FILL x0A
palindrome_string .STRINGZ " IS a palindrome\n"
not_palindrome_string .STRINGZ " IS NOT a palindrome\n"
.END

;subroutine: SUB_GET_STRING_3200
;Parameter (R1): The starting address of the character array
;Postcondition": The subroutine has prompted the user to input a string,
;   terminated by the [ENTER] key (the "sentinel"), and has stored
;   the received characters in an array of characters starting at (R1).
;   The array is NULL-terminated; the sentinel character is NOT stored.
;Return Value (R5): The number of non-sentinel chars read from the user.
;   R1 contains the starting address of the array unchanged.
.ORIG x3200
;instructions
;backup affected registers
ST R2, backup_r2_3200
ST R7, backup_r7_3200

;prompt user
LEA R0, prompt
PUTS

;get char input and array size
LD R5, arrsize
WHILE_LOOP
LD R2, enterkey
GETC
OUT
ADD R2, R2, R0
;end while loop if [ENTER] key is typed
BRz END_WHILE_LOOP
STR R0, R1, #0
ADD R1, R1, #1
ADD R5, R5, #1
BRnzp WHILE_LOOP
END_WHILE_LOOP

;store array size
ST R5, arrsize
;restore backup registers
LD R2, backup_r2_3200
LD R7, backup_r7_3200

RET
;data
arrsize .FILL #0
prompt .STRINGZ "Enter a string of text, ending with [ENTER] key.\n"
enterkey .FILL #-10
backup_r2_3200 .blkw #1
backup_r7_3200 .blkw #1
arr .BLKW #10
.END

;Subroutine: SUB_IS_PALINDROME_3400
;Parameter (R1): The starting address of a null-terminated string
;Parameter (R5): The number of characters in the array.
;Postcondition: The subroutine has determined whether the string at (R1)
;   is a palindrome or not, and returned a flag to that effect.
;Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
.ORIG x3400
;instructions
;backup affected registers
ST R2, backup_2_r2_3400
ST R3, backup_2_r3_3400
ST R6, backup_2_r6_3400
ST R7, backup_2_r7_3400

;load true into R4
LD R4, ispalindrome

;R1- front array memory addres
;R2- back array memory address
;loop through array and check front/back characters
ADD R2, R1, R5
ADD R2, R2, #-1

WHILE_LOOP_2
;check if front/back array addresss are same/passed
NOT R3, R1
ADD R3, R3, #1
ADD R3, R3, R2
;if addresses are same/passed in while loop, array is palindrome
BRnz FINISH

;check if front/back array values are same
LDR R3, R2, #0
NOT R3, R3
ADD R3, R3, #1
LDR R6, R1, #0

;if front/back array values are same continue loop
;if front/back array values arent same, array is not palindrome
ADD R6, R6, R3
BRnp IF_NOT_PALINDROME

;increment front/back array address
ADD R1, R1, #1
ADD R2, R2, #-1

BRnzp WHILE_LOOP_2

;load false into R4
IF_NOT_PALINDROME
LD R4, notpalindrome

;finish loop
FINISH

;restore backup registers
LD R2, backup_2_r2_3400
LD R3, backup_2_r3_3400
LD R6, backup_2_r6_3400
LD R7, backup_2_r7_3400

RET
;data
ispalindrome .FILL #1
notpalindrome .FILL #0
backup_2_r2_3400 .blkw #1
backup_2_r3_3400 .blkw #1
backup_2_r6_3400 .blkw #1
backup_2_r7_3400 .blkw #1
.END