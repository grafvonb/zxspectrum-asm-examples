;error handlers
        include lib_consts.asm
        include lib_trap_keys.asm

eh_proc:
        lea     eh_table(pc),a1         ;table start
        lea     eh_address_err(pc),a0
        move.l  a0,(a1)+                ;store address_err handler in table
        lea     eh_illegal_err(pc),a0
        move.l  a0,(a1)+                ;store illegal_err handler in table
        lea     eh_other(pc),a0
        move.l #16,d0                   ;number of vectors-1
eh_fill_table:
        move.l  a0,(a1)+                ;store other in the rest of the table
        dbf     d0,eh_fill_table        ;do all 17 vectors
        
        lea     eh_table(pc),a1            
        moveq   #CUR_JOB,d1             ;current job
        moveq   #MT_TRAPV,d0            ;set trap key
        trap    #1                      ;call QDOS
        rts

;address error exception handler
eh_address_err:
        move.l  #-15,d0                 ;'bad parameter'
        addq.l  #8,a7                   ;skip over extra words on stack
        bra     eh_print_error

;illegal exception handler
eh_illegal_err:
        move.l  #-19,d0                 ;'not implemented'
        addq.l  #2,2(a7)                ;restart at the next instruction
        bra     eh_print_error

eh_print_error:
        movea.w $0ca,a0                 ;get the vector
        jsr     (a0)                    ;call the 'print error message' routine
eh_other:
        rte                             ;end the execution

eh_table:
        ds.w    76
