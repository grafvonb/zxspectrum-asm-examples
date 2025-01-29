;just return to SuperBASIC

start:
        trap    #0              ;switch into supervisor mode
        andi    #$dfff,sr       ;get back to user mode

        clr.l   d0              ;has to be cleared, otherwise SuperBASIC reports an error
        rts