.ORIG x3000
;instructions
    LD R6, STACK_ADDR

    AND R0, R0, #0
    ADD R0, R0, #5

    ;call factorial subroutine on 5
    LD R5, FACT_ADDR
    JSRR R5
    
    HALT
;data
FACT_ADDR .FILL x3100
STACK_ADDR .FILL xFE00
.END

.ORIG x3100
;instructions
;backup affected registers
;r7 is rewritten to x3107 again because the register
;is backed up at the beginning of the subroutine
FACT ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R1, R6, #0
    
    ;finish loop once factorial hits 0
    ADD R1, R0, #-1
    BRz DONE

    ADD R1, R0, #0
    ADD R0, R1, #-1
    ;R7 return value is overriden
    JSR FACT
    LD R5, MUL_ADDR
    JSRR R5
    
DONE LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    RET
;data
MUL_ADDR .FILL x3200
.END

;SUBROUTINE MULTIPLY
.ORIG x3200
;instructions
;backup affected registers
MUL ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0

    ADD R2, R0, #0
    AND R0, R0, #0
    
LOOP ADD R0, R0, R1
    ADD R2, R2, #-1
    BRp LOOP
    
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    RET
;data
.END
    