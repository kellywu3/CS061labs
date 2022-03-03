.ORIG x3000
;instructions
LEA R1, array

LD R2, SUB_GET_STRING_3200
JSRR R2

LEA R0, array
PUTS

HALT
;data
SUB_GET_STRING_3200 .FILL x3200
array .BLKW #100
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
ST R2, backup_r2_3200
ST R7, backup_r7_3200

LEA R0, prompt
PUTS

LD R5, arrsize

WHILE_LOOP
LD R2, enterkey
GETC
OUT
ADD R2, R2, R0
BRz END_WHILE_LOOP
STR R0, R1, #0
ADD R1, R1, #1
ADD R5, R5, #1
BRnzp WHILE_LOOP
END_WHILE_LOOP

ST R5, arrsize
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