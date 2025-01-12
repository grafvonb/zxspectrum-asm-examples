;get the Qdos version which can be read in SuperBASIC as CALL does not allow return values
        include lib_trap_keys.asm        

        org     0

start:
        move.b  MT_INF,d0       ;define trap key, system information
        trap    #1              ;call

        rts

print_char:
        movem.l d0-d7/a0-a7,-(sp)       ;backup all regs
        and.l   #$ff,d1                 ;filter lowest nibble
        move.l  #$00010001,a0           ;set console channel id
        moveq   #-1,d3                  ;no timeout
        moveq   #IO_SBYTE,d0            ;define trap key
        trap    #3                      ;call trap
        movem.l (sp)+,d0-d7/a0-a7       ;restore all regs
        rts