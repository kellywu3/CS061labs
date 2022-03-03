;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kelly Wu
; Email: kwu116@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 025
; TA: James Luo
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

; output intro prompt
START_PROGRAM
LD R0, introPromptPtr
PUTS
; Set up flags, counters, accumulators as needed
;R1 = negative flag (0 -> positive, 1 -> negative)
;R2 = loop counter
;R3 = extra loop variable
;R4 = binary representation of user-entered decimal
;R5 = extra loop variable
AND R1, R1, #0
LD R2, loopCounter
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0

; Get first character, test for '\n', '+', '-', digit/non-digit 	
GETC
OUT
; is very first character = '\n'? if so, just quit (no message)!
ADD R0, R0, #-10
BRz END_INPUT
; is it = '+'? if so, ignore it, go get digits
; is it = '-'? if so, set neg flag, go get digits
ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-1
BRn ERROR
ADD R0, R0, #0
BRz GET_DIGITS

ADD R0, R0, #-2
BRz NEGATIVE

ADD R0, R0, #-3
BRn ERROR
ADD R3, R0, #-9
BRp ERROR
ADD R0, R0, #0
BRp INNER_MULTIPLY

NEGATIVE
ADD R1, R1, #1

GET_DIGITS
GETC
OUT

; is it 'enter'? if so, end program
ADD R0, R0, #-10
BRz END_INPUT

; is it < '0'? if so, it is not a digit	- o/p error message, start over
ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-6
BRn ERROR
; is it > '9'? if so, it is not a digit	- o/p error message, start over
ADD R3, R0, #-9
BRp ERROR

; if none of the above, first character is first numeric digit - convert it to number & store in target register!
LD R3, innerMultiplyVal
ADD R5, R4, #0
INNER_MULTIPLY
ADD R4, R4, R5
ADD R3, R3, #-1
BRp INNER_MULTIPLY

ADD R4, R4, R0

; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
ADD R2, R2, #-1
BRp GET_DIGITS
ADD R2, R2, #0
BRz END_INPUT

ERROR
LD R0, errorMessagePtr
PUTS
ADD R0, R0, #0
BRn START_PROGRAM

; remember to end with a newline!
END_INPUT
ADD R1, R1, #0
BRz POSITIVE

NOT R4, R4
ADD R4, R4, #1

POSITIVE
LD R0, enter
OUT
					
HALT

;---------------	
; Program Data
;---------------
enter .FILL x0A
loopCounter .FILL #5
innerMultiplyVal .FILL #9
introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
