; (1) Super Charge Your Spectrum, David Webb

    include "consts_lib.asm" 

    module webb

; upws - up whole screen
; (1) page 45
; modifies: hl,de
upws:
    ld      hl,consts.SCREEN_BITMAP_RAM_START       ; beginning of display RAM
    ld      de,consts.PRINTER_BUFFER                ; used to erase the contents of the last 32 bytes of the printer buffer
    ld      (hl),$ff
nxslice:
    push    de      ; destination
    push    hl      ; source
    ld      a,3     ; three parts of the screen
    ld      bc,$20  ; counter
nxthird:
    push    bc      ; store the top 'slice' of the top line in the printer buffer
    push    hl
    ldir            ; do ldi while bc>0, ldi: (de)=(hl), de++, hl++, bc--
    pop     de
    ld      c,$e0   ; 7*32=224
    ldir            ; next 7 lines (1-7) up into top 7 lines (0-6)
    ld      b,7
    add     hl,bc   ; find the first line of the next third of the screen
    dec     a       ; repeat until all of the top slices have been scrolled up a line
    pop     bc
    jr      nz,nxthird
    ld      a,(consts.TEST_23346)   ; test
    cp      1           ; decide whether to
    jr      c,leavit    ; leave,
    jr      nz,fill     ; fill or
roll:
    ld      hl,consts.PRINTER_BUFFER ; roll the top slice down into the bottom line
    ldir
    jr      leavit
fill:
    ld      b,c
nxt1:
    ld      a,(consts.TEST_23347)   ; (23347) is placed in the bottom line of the screen
    ld      (de),a
    djnz    nxt1
leavit:
    pop     hl      ; move to the second slice of each line,
    pop     de      ; and repeat the whole operation until
    inc     h       ; all 8 slices of all 24 lines have been scrolled
    ld      a,h
    cp      $48
    jr      c,nxslice
cleanup
    ex      de,hl   ; clean up the printer buffer
nxt2:
    ld      (hl),e
    inc     l
    jr      nz,nxt2
    ret

    endmodule