.ORIG x3000
;Instructions
LEA R0, prompt
PUTS

LD R0, newline
OUT
LEA R1, array_1
LD R2, cnt

DO_WHILE_1
GETC
OUT
STR R0, R1, #0
ADD R0, R0, #-10
BRz IS_ZERO
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
ADD R1, R1, #1
ADD R2, R2, #-1
BRp DO_WHILE_2
END_DO_WHILE_2

LD R0, newline
OUT

HALT

IS_ZERO
LD R0, newline
OUT
LEA R1, array_1
LD R2, cnt

DO_WHILE_3
LDR R0, R1, #0
OUT
ADD R1, R1, #1
ADD R2, R2, #-1
BRp DO_WHILE_3
END_DO_WHILE_3

HALT
;Local Data
cnt .FILL #100
prompt .STRINGZ "Enter characters. Press ENTER to end."
newline .FILL x0A
array_1 .BLKW #100
.END