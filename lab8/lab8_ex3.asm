;To right shift:
;Check if binary if negative/positive
;   If negative set negative flag to one
;   If positive set negative flag to zero
;Multiply bits by 2; add the binary to itself
;Add the negative flag
;->bits will be shifted and wrap around
;
;To left shift bits n many times do this (16 - n) times