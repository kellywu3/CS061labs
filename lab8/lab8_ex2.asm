.ORIG x3000
;instructions
LD R1, GET_USER_INPUT_3200
JSRR R1

LD R2, PARITY_CHECK_3400
JSRR R2

HALT
;data
GET_USER_INPUT_3200 .FILL x3200
PARITY_CHECK_3400 .FILL x3400
.END

;Subroutine: GET_USER_INPUT_3200
;Parameter: none
;Result: Input is passed in and stored in R1
;Return (R1): The input value is stored in R1
.ORIG x3200
ST R7, backup_R7_3200

LEA R0, prompt
PUTS

GETC
OUT

ADD R1, R0, #0

LD R7, backup_R7_3200

RET
;data
prompt .STRINGZ "Input a single character from the keyboard: "
backup_R7_3200 .BLKW #1
.END


;Subroutine: PARITY_CHECK_3400
;Parameter (R1): The input value
;Result: The number of binary 1's is output to console
;Return: none
.ORIG x3400
;instructions
ST R2, backup_R2_3400
ST R3, backup_R3_3400
ST R4, backup_R4_3400
ST R7, backup_R7_3400

;R2 contains a copy of R1
;R3 contains the 1 counter
;R4 contains the loop counter
ADD R2, R1, #0
AND R3, R3, #0
LD R4, binary_loop
WHILE_LOOP
ADD R2, R2, #0
BRzp SKIP_ADD
ADD R3, R3, #1

;ADD R0, R3, #0
;ADD R0, R0, #15
;ADD R0, R0, #15
;ADD R0, R0, #15
;ADD R0, R0, #3
;OUT

SKIP_ADD
ADD R2, R2, R2
ADD R4, R4, #-1
BRp WHILE_LOOP

LEA R0, result_one
PUTS

ADD R0, R1, #0
OUT

LEA R0, result_two
PUTS

ADD R0, R3, #0
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT

LD R2, backup_R2_3400
LD R3, backup_R3_3400
LD R4, backup_R4_3400
LD R7, backup_R7_3400

RET
;data
result_one .STRINGZ "\nThe number of 1's in '"
result_two .STRINGZ "' is: "
endline .FILL x0A
binary_loop .FILL #16
backup_R2_3400 .BLKW #1
backup_R3_3400 .BLKW #1
backup_R4_3400 .BLKW #1
backup_R7_3400 .BLKW #1
.END