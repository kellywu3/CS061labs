.ORIG x3000
;instructions
    AND R0, R0, #0
    ADD R0, R0, #5

    ;call factorial subroutine on 5
    LD R5, FACT_ADDER
    JSRR R5
    
    HALT
;data
FACT_ADDER .FILL x3100
.END

.ORIG x3100
;instructions
;backup affected registers
;r7 is rewritten to x3107 again because the register
;is backed up at the beginning of the subroutine
FACT ST R1, Save1_3100
    ST R7, Save7_3100
    
;finish loop once factorial hits 0
    ADD R1, R0, #-1
    BRz DONE

    ADD R1, R0, #0
    ADD R0, R1, #-1
    ;R7 return value is overriden
    JSR FACT
    LD R5, MUL_ADDR
    JSRR R5
    
DONE LD R1, Save1_3100
    LD R7, Save7_3100
    RET
;data
MUL_ADDR .FILL x3200

Save1_3100 .BLKW 1
Save7_3100 .BLKW 1
.END

;SUBROUTINE MULTIPLY
.ORIG x3200
;instructions
;backup affected registers
MUL ST R2, Save2_3200
    ST R7, Save7_3200

    ADD R2, R0, #0
    AND R0, R0, #0
    
LOOP ADD R0, R0, R1
    ADD R2, R2, #-1
    BRp LOOP
    
    LD R2, Save2_3200
    LD R7, Save7_3200
    RET
;data
Save2_3200 .BLKW 1
Save7_3200 .BLKW 1
.END
    