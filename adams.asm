    device	zxspectrum48

; const
ENTER = $0D

    org $8000
    include "screen_lib.asm"

    jp start
 
data:
    db "Hello World!",ENTER
DATA_LENGTH = $ - data

start:
    call screen.clear
    ld hl,$4000
    ld (hl),$FF
    ld hl,data
    ld b,DATA_LENGTH
print_loop:
    ld a,(hl)
    rst $10
    inc hl
    djnz print_loop
 
    ld bc,$0A05
    call screen.get_loc
    ld (hl),%10000001
    ld bc,$0B05
    call screen.get_loc
    ld ($5C84),hl
    ld a,$45
    rst $10

    // call screen.clear
    ret

    savesna "adams.sna",start
    