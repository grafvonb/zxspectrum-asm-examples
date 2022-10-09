    device	zxspectrum48

    include "screen_lib.asm"

; const
ENTER = $0D
 
    org $8000
    jp start
 
data:
    db "Hello World!",ENTER
DATA_LENGTH = $ - data

start:
    call screen.clear
    ld hl,data
    ld b,DATA_LENGTH
print_loop:
    ld a,(hl)
    rst $10
    inc hl
    djnz print_loop
    ret

    savesna "adams.sna",start
    