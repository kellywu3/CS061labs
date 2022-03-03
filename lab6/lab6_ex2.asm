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
ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-16

ADD R2, R2, R2
ADD R2, R2, R0

ADD R1, R1, #-1
BRp WHILE_LOOP

;restore affected registers
LD R1, backup_r1_3200
LD R7, backup_r7_3200

RET
;data
loop_counter .FILL #16
prompt .STRINGZ "Enter a 16-bit 2's complement binary number from the keyboard.\n"
prompt_2 .STRINGZ "Type 'b' followed by sixteen 1's and 0's (with no spaces on input)."
backup_r1_3200 .BLKW #1
backup_r7_3200 .BLKW #1
.END

