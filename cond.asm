    device	zxspectrum48
    
    org $8000

    jp start

; character codes
ENTER   = $0D
UPPER_A = $41
UPPER_Z = $5A
LOWER_A = $61
LOWER_Z = $7A

message:
    db "Like And Subscribe!",ENTER

MSG_LEN = $ - message   ; $ is the current address - message address = length

start:
    ; print original message
    ld hl,message
    ld b,MSG_LEN
orig_loop:
    ld a,(hl)
    rst $10             ; restart at zero page address s
    inc hl
    djnz orig_loop      ; dec B, jump non-zero      

    ; print all in lowercase
    ld hl,message
    ld a,(hl)
lower_loop:
    cp UPPER_A
    jr c,print_lower_char   ; if A < UPPER_A (c=1) just print
    cp UPPER_Z+1
    call c,to_lower         ; if between A-Z, change to lowercase
print_lower_char:
    rst $10
    inc hl
    ld a,(hl)
    cp ENTER
    jr nz,lower_loop        ; if A != ENTER jump (z=0)
    rst $10

    ; print all in uppercase
    ld hl,message
    ld b,MSG_LEN
upper_loop:
    ld a,(hl)
    call to_upper
    rst $10
    inc hl
    djnz upper_loop

    ; all done
    ret

to_lower:
    add $20                 ; A+=$20, change uppercase to lowercase
    ret

to_upper:
    cp LOWER_A
    ret c
    cp LOWER_Z+1
    ret nc
    sub $20
    ret

    savesna "cond.sna",start
    