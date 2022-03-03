;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kelly Wu
; Email: kwu116@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 025
; TA: James Luo
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD R2, loop_counter

OUTTER_FOR_LOOP
LD R3, loop_counter

INNER_FOR_LOOP

ADD R1, R1, #0
BRn CASE_ONE
ADD R1, R1, #0
BRzp CASE_ZERO

CASE_ONE
LD R0, one
OUT
BRnzp JUMP

CASE_ZERO
LD R0, zero
OUT
BRnzp JUMP

JUMP

ADD R1, R1, R1
ADD R3, R3, #-1
BRzp INNER_FOR_LOOP


ADD R2, R2, #0
BRz SKIP_SPACE
LD R0, space
OUT

SKIP_SPACE
ADD R2, R2, #-1
BRzp OUTTER_FOR_LOOP

LD R0, enter
OUT

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
loop_counter .FILL #3
enter .FILL x0A
space .FILL x20
zero .FILL x30
one .FILL x31
.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
