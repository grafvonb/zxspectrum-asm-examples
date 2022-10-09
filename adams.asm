    device	zxspectrum48

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

    module screen

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


    savesna "adams.sna",start
    