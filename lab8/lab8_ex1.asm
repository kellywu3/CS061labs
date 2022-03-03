.ORIG x3000
;main instructions
LD R1, LOAD_VAL_FROM_MEM_3200
JSRR R1

ADD R4, R4, #1

LD R1, PRINT_DEC_3400
JSRR R1

HALT
;data
LOAD_VAL_FROM_MEM_3200 .FILL x3200
PRINT_DEC_3400 .FILL x3400
.END

;Subroutine: LOAD_VAL_FROM_MEM_3200
;Parameter: none
;Result: The hard-coded value is loaded into R4
;Return (R4): The value is stored in R4
.ORIG x3200
;instructions
LD R4, DEC_RAND
RET
;data
DEC_RAND .FILL #32767
.END

;Subroutine: PRINT_DEC_3400
;Parameter (R4): The value in R4 to be printed to console
;Result: The value in R4 is printed to console
;Return: none, console output
.ORIG x3400
;instructions
;get first bit, if 0, output +, if 1, output -
;and branch to negative

ST R2, backup_R2_3400
ST R3, backup_R3_3400
ST R5, backup_R5_3400
ST R7, backup_R7_3400

ADD R4, R4, #0
BRn NEGATIVE

;output positive sign, ASCII #43/x2B
AND R0, R0, #0
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #13
OUT

BRnzp PRINT_NUMBER

NEGATIVE
;take twos complement, not value and add one
NOT R4, R4
ADD R4, R4, #1

;output positive sign, ASCII #45/x2D
AND R0, R0, #0
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
OUT

PRINT_NUMBER
;R0 contains current value at the nths place
;R2 contains the value stored in R4 after some number of nths place have been subtracted
;R3 contains the value stored in R4 to check the place value
;R5 contains the value to be subtracted to check how many digits
AND R0, R0, #0
ADD R0, R0, #-1
LD R5, five
ADD R3, R4, #0
FIVE_DIGITS
ADD R0, R0, #1
ADD R2, R3, #0
ADD R3, R3, R5
BRzp FIVE_DIGITS

ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT


AND R0, R0, #0
ADD R0, R0, #-1
LD R5, four
ADD R3, R2, #0
FOUR_DIGITS
ADD R0, R0, #1
ADD R2, R3, #0
ADD R3, R3, R5
BRzp FOUR_DIGITS

ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT


AND R0, R0, #0
ADD R0, R0, #-1
LD R5, three
ADD R3, R2, #0
THREE_DIGITS
ADD R0, R0, #1
ADD R2, R3, #0
ADD R3, R3, R5
BRzp THREE_DIGITS

ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT


AND R0, R0, #0
ADD R0, R0, #-1
LD R5, two
ADD R3, R2, #0
TWO_DIGITS
ADD R0, R0, #1
ADD R2, R3, #0
ADD R3, R3, R5
BRzp TWO_DIGITS

ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT


AND R0, R0, #0
ADD R0, R0, #-1
ADD R3, R2, #0
ONE_DIGIT
ADD R0, R0, #1
ADD R2, R3, #0
ADD R3, R3, #-1
BRzp ONE_DIGIT

ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT

LD R2, backup_R2_3400
LD R3, backup_R3_3400
LD R5, backup_R5_3400
LD R7, backup_R7_3400

RET
;data
five .FILL #-10000
four .FILL #-1000
three .FILL #-100
two .FILL #-10
backup_R2_3400 .BLKW #1
backup_R3_3400 .BLKW #1
backup_R5_3400 .BLKW #1
backup_R7_3400 .BLKW #1
.END
