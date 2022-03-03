.ORIG x3000
;instructions
LD R1, READ_BINARY_3200
JSRR R1

HALT
;data
READ_BINARY_3200 .FILL x3200
.END

;Subroutine: READ_BINARY_3200
;Parameter (R6): Pointer to the address of the value to be converted
;Postcondition: The subroutine has captured the binary input and stored it to R2
;Return value (R2): The value input is stored in R2
.ORIG x3200
;instructions
;backup affected registers
ST R1, backup_r1_3200
ST R3, backup_r3_3200
ST R7, backup_r7_3200

AND R2, R2, #0

LEA R0, prompt
PUTS
LEA R0, prompt_2
PUTS

GETC
OUT

LD R1, loop_counter
;ascii x30 = 0 = 48
;ascii x31 = 1 = 49
WHILE_LOOP
GETC
OUT
LD R3, FLIP_BITS_3400
JSRR R3

ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-16

ADD R2, R2, R2
ADD R2, R2, R0

ADD R1, R1, #-1
BRp WHILE_LOOP

LD R3, PRINT_BINARY_3600
JSRR R3

;restore affected registers
LD R1, backup_r1_3200
LD R3, backup_r3_3200
LD R7, backup_r7_3200

RET
;data
loop_counter .FILL #16
FLIP_BITS_3400 .FILL x3400
PRINT_BINARY_3600 .FILL x3600
prompt .STRINGZ "Enter a 16-bit 2's complement binary number from the keyboard.\n"
prompt_2 .STRINGZ "Type 'b' followed by sixteen 1's and 0's (with no spaces on input)."
backup_r1_3200 .BLKW #1
backup_r3_3200 .BLKW #1
backup_r7_3200 .BLKW #1
.END

;Subroutine: FLIP_BITS_3400
;Parameter (R0): The bit value
;Postcondition: The bit is flipped (0 -> 1; 1 -> 0)
;Return value (R0): The flipped bit is stored in R0
.ORIG x3400
;instructions
;backup affected registers
ST R1, backup_r1_3400

ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-16
BRz RETURN_ONE

ADD R0, R0, #-1
BRz RETURN_ZERO

RETURN_ONE
LD R0, one
BRnzp FINISH

RETURN_ZERO
LD R0, zero
BRnzp FINISH

FINISH

;restore affected registers
LD R1, backup_r1_3400
RET
;data
zero .FILL x30
one .FILL x31
backup_r1_3400 .BLKW #1
.END

;Subroutine: PRINT_BINARY_3600
;Parameter (R2): The binary to be printed
;Postcondition: The stored binary is printed
;Return value: The stored binary is printed
.ORIG x3600
;instructions
;backup affected registers
ST R3, backup_r3_3600

LD R0, ascii_enter
OUT

LD R3, counter

WHILE_LOOP_2
ADD R2, R2, #0
BRp CASE_ZERO

ADD R2, R2, #0
BRn CASE_ONE

CASE_ZERO
LD R0, ascii_zero
OUT
BRnzp NEXT_WHILE_2

CASE_ONE
LD R0, ascii_one
OUT
BRnzp NEXT_WHILE_2

NEXT_WHILE_2
ADD R2, R2, R2
ADD R3, R3, #-1
BRp WHILE_LOOP_2

LD R0, ascii_enter
OUT

;restore affected registers
LD R3, backup_r3_3600

RET
;data
ascii_zero .FILL x30
ascii_one .FILL x31
ascii_enter .FILL x0A
backup_r3_3600 .BLKW #1
counter .FILL #16
.END

