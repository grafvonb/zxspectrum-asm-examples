/*
  screen_lib
  Contains helper procedures for screen operations.
*/

    module screen

; clears whole screen with 0 value
clear:
    push bc
    push de
    push hl
    ld hl,$4000     ; HL = start of screen bitmap
    ld de,$4001     ; DE = HL + 1
    ld bc,$17FF     ; BC = length of screen bitmap ($4000 - $57FF)
    ld (hl),0       ; clear
    ldir            ; LDI while BC>0, LDI: (DE)=(HL), DE++, HL++, BC--
    pop hl
    pop de
    pop bc
    ret

    endmodule

