.ORIG x3000
;instructions
LD R3, counter
LD R4, arr_start
LD R5, arr_pointer

DO_WHILE_LOOP
STR R4, R5, #0
ADD, R4, R4, R4
ADD R5, R5, #1
ADD R3, R3, #-1
BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

LD R6, val_counter
LD R5, arr_pointer
DO_WHILE_LOOP_2
LDR R0, R5, #0
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT
ADD R5, R5, #1
ADD R6, R6, #-1
BRp DO_WHILE_LOOP_2
END_DO_WHILE_LOOP_2

HALT
;data
counter .FILL #10
arr_start .FILL #1
arr_pointer .FILL x4000
val_counter .FILL #10
.END

.ORIG x4000
arr .BLKW #10
.END