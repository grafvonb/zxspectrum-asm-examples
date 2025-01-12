;Trap 1 Keys - Manager Traps (MT)
MT_INF          equ     $00     ;Get system information
                                ;call params:
                                ;   -
                                ;ret params:
                                ;   d1.l   - current job id
                                ;   d2.l   - ASCII version (n.nn)
                                ;   a0     - pointer to system vars

MT_CJOB         equ     $01     ;create a job
MT_JINF         equ     $02     ;get information on job
MT_RJOB         equ     $04     ;remove a job
MT_FRJOB        equ     $05     ;force remove a job
MT_FREE         equ     $06     ;find how much free space there is

MT_TRAPV        equ     $07     ;Set pointer to trap redirection vectors
                                ;Note: When a routine in the table is entered as a result of an exception,
                                ;      the CPU is in supervisor mode. The routine should return with an rte
                                ;      command (not rts). Any registers used must be saved and restored.
                                ;call params:
                                ;   d1.l   - job id
                                ;   a1     - pointer to table
                                ;ret params:
                                ;   d1.l   - job id
                                ;   a0     - base of job

;Trap 3 Keys - I/O Traps (IO)
IO_PEND         equ     $00     ;check for pending input
IO_FBYTE        equ     $01     ;fetch a byte
IO_FLINE        equ     $02     ;fetch a line of bytes
IO_FSTRG        equ     $03     ;fetch a string of bytes
IO_EDLIN        equ     $04     ;edit a line

IO_SBYTE        equ     $05     ;Send a byte
                                ;call params: 
                                ;   d1.b   - byte to be sent
                                ;   d3.w   - timeout
                                ;   a0     - channel ID
                                ;ret params:
                                ;   -
                                ;errors:
                                ;   NC     - not complete
                                ;   NO     - channel not open
                                ;   DF     - drive full
                                ;   OR     - off window/paper etc