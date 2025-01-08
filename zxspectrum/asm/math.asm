    device	zxspectrum48

ENTER = $0D

    org $8000

    jp start

scratch:
    dw 0            ; 2 bytes of RAM for general temporary use

start:
    ld a,$10
    add a,$02           ; A = $12, clears all flags
    ld hl,$3456
    call print_afhl     ; print A,F,H,L registers
    ld d,$0E            ; A = $12 + $0E = $20, sets H
    call print_afhl
    ld hl,scratch       ; HL = $8003
    ld (hl),$60
    add a,(hl)          ; A = $20 + $60 = $80, sets S and P/V
    call print_afhl
    add a,h             ; A = $80 + $80 = $00, sets Z, P/V and C
    call print_afhl
    inc a               ; A = $01, clears all flags, butleaves C set
    call print_afhl
    neg                 ; A = $00 - $01 = $FF, sets S, H, N, and C
    call print_afhl
    ld bc,$0003
    sbc hl,bc           ; HL = $8003 - $0003 - 1 = $7FFF, sets H, P/V, and N
    call print_afhl
    sbc hl,hl           ; HL = $0000, sets Z and N
    call print_afhl
    ret 

print_afhl:
    push hl
    push af
    call print_hex      ; print A in hex
    ld (scratch),sp
    ld bc,(scratch)     ; BC = stack pointer address
    ld a,(bc)           ; A = F at top of the stack
    call print_hex      ; print F
    ld a,h
    call print_hex      ; print H
    ld a,l
    call print_hex      ; print L
    ld a,ENTER
    rst $10
    pop af
    pop hl
    ret

print_hex:
    push hl
    push af
    srl a
    srl a
    srl a
    srl a                   ; A >> 4
    call print_hex_digit    ; print high nybble
    pop af                  ; restore A
    and $0F                 ; clear high nybble
    call print_hex_digit    ; print low nybble
    pop hl
    ret

print_hex_digit:
    cp $0A
    jp p,print_letter       ; if S clear, A >= $0A
    or $30                  ; A < $0A, just put $3 in upper nybble for number code
    jp print_char
print_letter:
    add $37                 ; A >= $0A, add $37 to get letter code
print_char:
    rst $10
    ret

    savesna "math.sna",start
