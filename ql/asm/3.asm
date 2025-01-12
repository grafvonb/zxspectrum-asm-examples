;scrolls the screen up one line

        move.w  #$0a,d1
start:
        move.w  #$1fdf,d0               ;set count $7f7f/4 (because of long word)
        move.l  #$20080,a0              ;define first location on the screen 0
loop:
        move.l  (a0),-128(a0)           ;move a long word
        addq.l  #4,a0                   ;switch to next location on the screen 0
        dbf     d0,loop                 ;decrement d0, branch if not false (-1)
        dbf     d1,start

        clr.l   d0
        rts