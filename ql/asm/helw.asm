;Hello world! on screen 0
        include lib_trap_keys.asm

        org     0

start:
        lea     message_data(pc),a3         ;point on data
        bsr     print_string
        bsr     print_new_line

        clr.l   d0
        rts

message_data:
        dc.b    'Hello World!',$ff
        even

print_string:
        move.b  (a3)+,d1                ;read a char
        cmp.b   #$ff,d1                 ;check if at the end of string
        beq     print_string_done       ;exit
        bsr     print_char              ;print char
        bra     print_string            ;loop to next char
print_string_done:
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

print_new_line:
        move.b  #$0a,d1                 ;define LF char
        bsr     print_char
        rts