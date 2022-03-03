;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kelly Wu
; Email: kwu116@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC
ADD R1, R1, R0
OUT
LD R0, newline
OUT
GETC
ADD R2, R2, R0
OUT
LD R0, newline
OUT

ADD R0, R1, #0
OUT
LD R0, space
OUT
LD R0, dash
OUT
LD R0, space
OUT
ADD R0, R2, #0
OUT
LD R0, space
OUT
LD R0, equal
OUT
LD R0, space
OUT

ADD R1, R1, #-16
ADD R1, R1, #-16
ADD R1, R1, #-16

ADD R2, R2, #-16
ADD R2, R2, #-16
ADD R2, R2, #-16

NOT R2, R2
ADD R2, R2, 1

ADD R3, R1, R2
BRn IS_NEGATIVE

ADD R3, R3, #15
ADD R3, R3, #15
ADD R3, R3, #15
ADD R3, R3, #3
ADD R0, R3, #0
OUT
LD R0, newline
OUT

HALT

IS_NEGATIVE
ADD R2, R2, -1
NOT R2, R2
NOT R1, R1
ADD R1, R1, 1
AND R3, R3, #0
ADD R3, R1, R2
LD R0, dash
OUT

ADD R3, R3, #15
ADD R3, R3, #15
ADD R3, R3, #15
ADD R3, R3, #3
ADD R0, R3, #0
OUT
LD R0, newline
OUT

HALT

; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL x0A	; newline character - use with LD followed by OUT
equal   .FILL x3D
dash    .FILL x2D
space   .FILL x20
offset  .FILL x30
num1    .FILL x00
num2    .FILL x00
;---------------	
;END of PROGRAM
;---------------	
.END

