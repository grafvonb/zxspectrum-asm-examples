;fill screen 0 ($20000-$27fff with pattern)

start:
        move.l  #$20000,a0
        move.l  #$aaaaaaaa,d0
        move.w  #$2000,d1
loop:
        move.l  d0,(a0)+
        ;subq    #1,d1
        ;bne     loop   
        dbf     d1,loop 

        clr.l   d0
        rts