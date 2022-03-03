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

LD R5, arr_pointer
ADD R5, R5, #6

LDR R2, R5 #0

HALT
;data
counter .FILL #10
arr_start .FILL #1
arr_pointer .FILL x4000
.END

.ORIG x4000
arr .BLKW #10
.END