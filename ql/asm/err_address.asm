;simulation of the address error (Number 3, location $00c)
        org     0

        include lib_err_handlers.asm

start:
        lea     data(pc),a0
        move.b  (a0)+,d0
        move.w  (a0),d1

        clr.l   d0
        rts

data:
        dc.w    0,0,0,0