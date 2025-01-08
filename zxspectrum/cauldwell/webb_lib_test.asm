    device	zxspectrum48

    org $8000
    include "screen_lib.asm"
    include "webb_lib.asm"
    include "consts_lib.asm"
    include "cauldwell_lib.asm"

    jp start
 
data:
    db "Hello World!",consts.ENTER
    db "Hello World 2!",consts.ENTER
    db "Hello World 3!",consts.ENTER
    db "Hello World 4!",consts.ENTER
    db "Hello World 5!",consts.ENTER
    db "Hello World 6!",consts.ENTER
DATA_LENGTH = $ - data

start:
    call cauldwell.set_bold_font
    call screen.clear
    call cauldwell.set_screen_to_upper   
    ld hl,$4000
    ld hl,data
    ld b,DATA_LENGTH
print_loop:
    ld a,(hl)
    rst $10
    inc hl
    djnz print_loop

    call webb.upws
    ret

    savesna "webb_lib_test.sna",start
    