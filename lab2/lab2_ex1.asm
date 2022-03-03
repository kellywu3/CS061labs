.ORIG x3000
;Instructions
LD R3, DEC_65
LD R4, HEX_41

HALT
;Local Data
DEC_65 .FILL #65 ;#65 -> A
HEX_41 .FILL x41 ;x41 -> A
.END
