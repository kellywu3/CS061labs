.ORIG x3000
;Instructions
LEA R0, prompt
PUTS

LEA R1, array_1
LD R2, cnt

DO_WHILE_1
GETC
OUT
STR R0, R1, #0
ADD R1, R1, #1
ADD R2, R2, #-1
BRp DO_WHILE_1
END_DO_WHILE_1

LD R0, newline
OUT
LEA R1, array_1
LD R2, cnt

DO_WHILE_2
LDR R0, R1, #0
OUT
LD R0, newline
OUT
ADD R1, R1, #1
ADD R2, R2, #-1
BRp DO_WHILE_2
END_DO_WHILE_2

HALT
;Local Data
cnt .FILL #10
prompt .STRINGZ "Enter 10 characters: "
newline .FILL x0A
array_1 .BLKW #10
.END