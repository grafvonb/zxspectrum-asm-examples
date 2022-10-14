; screen_lib
; contains helper procedures for screen operations.
; (1) Machinencode-Programme für den ZX Spectrum, Davie Laine
; (2) Advanced Spectrum Machine Language, David Webb

    module screen

; calculates address of a cell 
; from (2), page 6
; in: B = line (0-23)
; in: C = column (0-31)
; out: HL = address in display
; preserved: BC, DE
get_loc:
    ld a,b
    and $F8         ; %11111000
    add $40         ; %01000000
    ld h,a
    ld a,b
    and $7          ; %00000111
    rrca
    rrca
    rrca
    add a,c
    ld l,a
    ret

; clears whole screen with 0 value
; from (1), page 56
; 
clear:
    push de
    push bc
    push hl
    ld hl,$4000     ; HL = start of screen bitmap
    ld de,$4001     ; DE = HL + 1
    ld bc,$17FF     ; BC = length of screen bitmap ($4000 - $57FF)
    ld (hl),0       ; clear
    ldir            ; LDI while BC>0, LDI: (DE)=(HL), DE++, HL++, BC--
    pop hl
    pop bc
    pop de
    ret

    endmodule

