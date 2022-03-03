.ORIG x3000
;instructions
LD R2, counter
LD R3, arr_start
LD R4, arr_pointer

DO_WHILE_LOOP
STR R3, R4, #0
ADD, R3, R3, R3
ADD R4, R4, #1
ADD R2, R2, #-1
BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

LD R3, val_counter
LD R6, arr_pointer
DO_WHILE_LOOP_2
LDR R2, R6, #0
ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #3
LD R1, TO_BINARY_3200
JSRR R1
ADD R6, R6, #1
ADD R3, R3, #-1
BRp DO_WHILE_LOOP_2
END_DO_WHILE_LOOP_2

HALT
;data
counter .FILL #10
arr_start .FILL #1
arr_pointer .FILL x4000
val_counter .FILL #10
TO_BINARY_3200 .FILL x3200
.END

.ORIG x4000
arr .BLKW #10
.END


;Subroutine: TO_BINARY_3200
;Parameter (R6): Pointer to the address of the value to be converted
;Postcondition: The subroutine has converted the value stored in R6 to binary and printed it
;No return value, outputs the value pointed at R6 in binary
.ORIG x3200
;instructions
;backup affected registers
ST R1, backup_r1_3200
ST R2, backup_r2_3200
ST R3, backup_r3_3200
ST R7, backup_r7_3200

LDR R1, R6, #0

LD R2, loop_counter

OUTTER_FOR_LOOP
LD R3, loop_counter

INNER_FOR_LOOP

ADD R1, R1, #0
BRn CASE_ONE
ADD R1, R1, #0
BRzp CASE_ZERO

CASE_ONE
LD R0, one
OUT
BRnzp JUMP

CASE_ZERO
LD R0, zero
OUT
BRnzp JUMP

JUMP

ADD R1, R1, R1
ADD R3, R3, #-1
BRzp INNER_FOR_LOOP


ADD R2, R2, #0
BRz SKIP_SPACE
LD R0, space
OUT

SKIP_SPACE
ADD R2, R2, #-1
BRzp OUTTER_FOR_LOOP

LD R0, enter
OUT

;restore affected registers
LD R1, backup_r1_3200
LD R2, backup_r2_3200
LD R3, backup_r3_3200
LD R7, backup_r7_3200

RET
;data
loop_counter .FILL #3
enter .FILL x0A
space .FILL x20
zero .FILL x30
one .FILL x31
backup_r1_3200 .BLKW #1
backup_r2_3200 .BLKW #1
backup_r3_3200 .BLKW #1
backup_r7_3200 .BLKW #1
.END

