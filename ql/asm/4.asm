;write message
;from QL Assembly Language Programming by Colin Opie

        org     0

MYSELF          equ     -1      ;if negative then the job is the current job
MT_FRJOB        equ     $05     ;force remove job from transient program area
SD_SETST        equ     $2d     ;set character size and spacing
UT_SCR          equ     $c8     ;set up screen windows
UT_MTEXT        equ     $d0     ;send a message to a channel

header:
        bra     start
        dc.l    0
        dc.w    $4afb           ;standard header
        dc.w    7
        dc.b    'Message'
        even

start:
        lea     scr(pc),a1      ;set up a screen
        move.w  UT_SCR,a4
        jsr     (a4)            ;call vector
        bne     error_handler   ;check error return

        moveq   #SD_SETST,d0    ;set character size
        moveq   #3,d1           ;wide
        moveq   #1,d2           ;tall
        moveq   #-1,d3          ;no timeout
        trap    #3

        lea     hello(pc),a1    ;write a message
        move.w  UT_MTEXT,a4
        jsr     (a4)

        clr.l   d0
        rts

error_handler:
        move.l  d0,d3           ;notify any error
        moveq   #MT_FRJOB,d0    ;force remove
        moveq   #MYSELF,d1      ;current job
        trap    #1

scr:
        dc.b    $ff             ;checkerboard border
        dc.b    $04             ;4 pixels wide
        dc.b    $04             ;green background
        dc.b    $00             ;black letters
        dc.w    200             ;200 pixel wide
        dc.w    35              ;35 high
        dc.w    156             ;in the middle
        dc.w    100

hello:
        dc.w    5               ;text length
        dc.b    'Hallo'

        end


