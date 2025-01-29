        org     0

SCREEN  equ     $20000
PC_INTR equ     $18021

        trap    #0
        ori     #%0000011100000000,sr

repeat  lea     sinus,a5
        lea     SCREEN,a6
loop    move.l  a6,a0
        move.l  blue,d0
        bsr     draw_ln
        lea     SCREEN,a6
        clr.w   d2
        move.b  (a5)+,d2
        cmpi    #$ff,d2
        beq     repeat        
        mulu    #$80,d2
        adda.l  d2,a6
        move.l  a6,a0
        move.l  white,d0
        bsr     draw_ln

        bset    #3,PC_INTR
intLp   move.b  PC_INTR,d1              ; wait for (any) interrupt
        btst    #3,d1
        beq     intLp                   ; no, busy wait

        jmp     loop

draw_ln 
        move.l  a0,a1
        moveq   #$1f,d1
draw_ln_loop    
        move.l  d0,(a1)+
        dbeq    d1,draw_ln_loop
        rts

waitVBlank
        move.b #%11111111,$18021    ;Clear interrupt bits
waitVBlankAgain
        move.b $18021,d0            ;Read in interrupt state
        tst.b d0                    ;Wait for an interrupt
        beq waitVBlankAgain
        rts

black:  dc.l    %00000000000000000000000000000000   ;line of 8-points black
blue:   dc.l    %00000000010101010000000001010101   ;line of 8-points blue
white:  dc.l    %10101010111111111010101011111111   ;line of 8-points white

sinus:  dc.b    $32,$34,$35,$37,$39,$3b,$3c,$3e
        dc.b    $40,$41,$43,$45,$46,$48,$49,$4b
        dc.b    $4c,$4e,$4f,$51,$52,$53,$55,$56
        dc.b    $57,$58,$59,$5a,$5b,$5c,$5d,$5e
        dc.b    $5f,$60,$60,$61,$62,$62,$63,$63
        dc.b    $63,$64,$64,$64,$64,$64,$64,$64
        dc.b    $64,$64,$63,$63,$63,$62,$62,$61
        dc.b    $60,$60,$5f,$5e,$5d,$5c,$5b,$5a
        dc.b    $59,$58,$57,$56,$55,$53,$52,$51
        dc.b    $4f,$4e,$4c,$4b,$49,$48,$46,$45
        dc.b    $43,$41,$40,$3e,$3c,$3b,$39,$37
        dc.b    $35,$34,$32,$30,$2f,$2d,$2b,$29
        dc.b    $28,$26,$24,$23,$21,$1f,$1e,$1c
        dc.b    $1b,$19,$18,$16,$15,$13,$12,$11
        dc.b    $f,$e,$d,$c,$b,$a,$9,$8
        dc.b    $7,$6,$5,$4,$4,$3,$2,$2
        dc.b    $1,$1,$1,$0,$0,$0,$0,$0
        dc.b    $0,$0,$0,$0,$1,$1,$1,$2
        dc.b    $2,$3,$4,$4,$5,$6,$7,$8
        dc.b    $9,$a,$b,$c,$d,$e,$f,$11
        dc.b    $12,$13,$15,$16,$18,$19,$1b,$1c
        dc.b    $1e,$1f,$21,$23,$24,$26,$28,$29
        dc.b    $2b,$2d,$2f,$30,$32
        dc.b    $ff