.ORIG x3000
;this stack lab computes the polish notation of a set of calls
LD R1, stack
;push_val(4) pushes the value 4 onto the stack [4]
LD R2, dec_four
LD R4, PUSH_VAL_3400
JSRR R4
;push_val(3) pushes the value 3 onto the stack [4,3]
LD R2, dec_three
JSRR R4
;push_val(2) pushes the value 2 onto the stack [4,3,2]
LD R2, dec_two
JSRR R4
;add_val() pop 3,2 and push the result of 3+2 onto the stack [4,5]
LD R4, ADD_VAL_3800
JSRR R4
;add_val() pop 4,5 and push the result of 4+5 onto the stack[9]
LD R4, ADD_VAL_3800
JSRR R4
;move the top value of the stack into r4
LDR R4, R1, #0
LDR R0, R1, #0
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT

HALT
dec_four .FILL #4
dec_three .FILL #3
dec_two .FILL #2
PUSH_VAL_3400 .FILL x3400
ADD_VAL_3800 .FILL x3800
stack .FILL xFE00
.END

.ORIG x3400
;;push_val(int val) implement your push function that will push a value onto the stack
;Subroutine: PUSH_VAL_3400
;Parameter (R1): The address of the stack located at xFE00
;Parameter (R2): The value to be pushed to the stack
;Result: The value is pushed to the stack located at xFE00
;Return: none

ADD R1, R1, #-1
STR R2, R1, #0

RET
.END

.ORIG x3800
;; add_val() pops two values from the top of the stack and pushes the result of adding the poppped value into the stack
;Subroutine: ADD_VAL_3800
;Parameter (R1): The address of the stack located at xFE00
;Result: The top two values are popped, added, and the result of the addition is pushed to the stack
;Return: none
ST R3, backup_r3_3800
ST R4, backup_r4_3800

LDR R3, R1, #0
ADD R1, R1, #1
LDR R4, R1, #0
ADD R1, R1, #1

ADD R3, R3, R4

ADD R1, R1, #-1
STR R3, R1 #0

LD R3, backup_r3_3800
LD R4, backup_r4_3800

RET
backup_r3_3800 .BLKW #1
backup_r4_3800 .BLKW #1
.END

.ORIG x4200
;;data you might need
.END
