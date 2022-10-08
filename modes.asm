    DEVICE	ZXSPECTRUM48
    
    org $8000

    jp start                ; jump over data to code (extended immediate)

string:
    db "hello"

STRING_LENGTH   = 5

ROM_CLS         = $0DAF     ; ROM address for "Clear Screen" routine
COLOR_ATTR      = $5800     ; start of color attribute memory
ENTER           = $0D       ; character code for Enter key
BLACK_WHITE     = $47       ; black paper, white ink

start:
    im  1                   ; set interrupt mode to 1 (interrupt mode)
    call ROM_CLS            ; call clear screen routine from ROM (extended immediate)
    ld hl,string            ; HL = address of string (register, extended immediate)
    ld b,STRING_LENGTH      ; B = length of string (register, immediate)
loop:
    ld a,(hl)               ; A = byte at address in HL (register, register indirect)
    rst $10                 ; print character code in A (modified page zero)
    inc hl                  ; increment HL to address of next character (register)
    dec b                   ; decrement B (register)
    jr  nz,loop             ; if B not zero, jump back to top of loop (condition, relative)
    ld a,ENTER              ; A = Enter character code (register, immediate)
    rst $10                 ; printe Enter for new line (modified page zero)

    ; chage color of the first character printed
    ld a,BLACK_WHITE        ; A = black/white color attribure (register, immediate)
    ld (COLOR_ATTR),a       ; color attribute(0,0) = A (extended, register)

    ; do it again, but unrolled and with the first letter capitalized
    ld ix,string            ; IX = address of string (register, extended immediate)
    res 5,(ix)              ; reset bit 5 of first character (bit, indexed)
    ld a,(ix)               ; A = string[0] (register, indexed)
    rst $10
    ld a,(ix+1)             ; A = string[1]
    rst $10
    ld a,(ix+2)             ; A = string[2]
    rst $10
    ld a,(ix+3)             ; A = string[3]
    rst $10
    ld a,(ix+4)             ; A = string[4]
    rst $10
    ld a,ENTER              ; A = Enter
    rst $10

    ret                     ; return from call (implied)

    SAVESNA "modes.sna",start
    
    