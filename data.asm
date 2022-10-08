; creating color bitmap
; ldi, ldd, comparing bc == 0? for long loop
; ldir, lddr


    device	zxspectrum48
    
    org $8000

start:
    ld a,%11001100
    ld de,$4000
    ld (de),a
    ex de,hl
    ld de,$4001
    ld bc,$200
bitmap_loop:
    ldi                 ; (de)=(hl), hl++, de++, bc--
    ld a,b              ; a=b
    or c                ; a OR c 
    jr nz,bitmap_loop   ; if (a | c) != 0 (if b == 0 and c == 0 => no loop)
    srl (hl)            ; shift pattern to right
    ld bc,$200
    ldir                ; load and increment repeated
    srl (hl)
    ld de,$45FF
    ldd                 ; (de)=(hl), hl--, de--, bc--
    ld bc,$1FE          ; first and last block already filled so just the middle        
    ld hl,$45FF
    lddr                ; fill the third block backwards
    ld hl,$4600
    ld (hl),%10011001
    ld de,$4601
    ld bc,$1FF
    exx                 ; copy to shadow regs, to use values later
    ld hl,$5800
    ld (hl),$41         ; blue on black
    ld de,$5801
    ld bc,$FF
color_loop:
    ldi
    inc (hl)            ; inc ink color
    ld a,$07
    and (hl)            ; check if ink set to zero (black)
    jr nz,next
    ld (hl),$41         ; reload color
next:
    ld a,b
    or c
    jr nz,color_loop
    exx                 ; bring back 4th block addresses
    ldir                ; fill it
    ret

    savesna "data.sna",start
   