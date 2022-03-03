;----------------
; Wu, Kelly
; kwu116 (kwu116@ucr.edu)
; Lab Section: 025
; TA: Sean Foley
; Lab 1
;----------------
.ORIG x3000
    ;----------------
    ; Instructions
    ;----------------
    AND R1, R1, x0
    LD R2, DEC_12
    LD R3, DEC_6
    
    
    DO_WHILE_LOOP
        ADD R1, R1, R2
        ADD R3, R3, #-1
        BRp DO_WHILE_LOOP
    END_DO_WHILE_LOOP
    
    HALT
    ;----------------
    ; Local Data
    ;----------------
    DEC_0   .FILL   #0
    DEC_12  .FILL   #12
    DEC_6   .FILL   #6

.END