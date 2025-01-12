;hp - hex_print
;prints value of d1 as 8 digit hex

start:
        move.l  #$bcdef123,d1
        bsr     print_8_dig_hex

        clr.l   d0
        rts

print_8_dig_hex:
        moveq   #7,d0                   ;set count for 8 digits
loop:
        rol.l   #4,d1                   ;rotate nibble (4 bits) links, it puts highest nibble (at bits 28-31) into the lowest four bits 
        move.l  d1,-(a7)                ;backup d1 on stack
        and.b   #$0f,d1                 ;filter the lowest nibble
        cmp.b   #$9,d1                  ;check if higher as #$9
        ble     it_is_digit             ;skip if digit
        addq.b  #7,d1                   ;add #$7 to get ASCII character A-F
it_is_digit:
        add.b   #$30,d1                 ;add base for ASCII characters, "0"=$30
        bsr     print_char              ;print character
        move.l  (a7)+,d1                ;restore d1 from stack
        dbf     d0,loop                 ;loop for all digits
        rts

print_char:
        movem.l d0-d1/d3/a0-a1,-(a7)    ;backup regs on stack
        move.l  #$00010001,a0           ;define console channelId (internal QDOS code)
        moveq.l #-1,d3                  ;define timeout
        moveq.l #5,d0                   ;IO.SBYTE (send byte)
        trap    #3                      ;IO TRAP
        movem.l (a7)+,d0-d1/d3/a0-a1    ;restore regs from stack
        rts