; How to Write ZX Spectrum Games, Jonathan Cauldwell

    include "consts_lib.asm"

COPY_FONT_ADDR = 60000
OPEN_CHANNEL_PROC = 5633

    module cauldwell

set_screen_to_upper:
    ld      a,2          ; open channel #2 (upper screen)
    call    OPEN_CHANNEL_PROC

set_bold_font:
    push    de
    push    bc
    push    hl
    ld      hl,consts.ROM_FONT_ADDR
    ld      de,COPY_FONT_ADDR
    ld      bc,$300                     ; 96 chars * 8 rows
bf_nxt:
    ld      a,(hl)      ; get bitmap
    rlca                ; rotate it left
    or      (hl)        ; combine
    ld      (de),a      ; store
    inc     hl          ; next byte of old
    inc     de          ; next byte of new
    dec     bc          ; decrement counter
    ld      a,b         ; high byte combine with low byte
    or      c
    jr      nz,bf_nxt      ; repeat until bc=0
    ld      hl,COPY_FONT_ADDR-256   ; font minus 32*8
    ld      (consts.ROM_FONT_ADDR_POINTER),hl
    pop     hl
    pop     bc
    pop     de
    ret

    endmodule