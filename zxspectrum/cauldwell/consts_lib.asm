    module consts

; screen bitmap 256x192, 6kB
SCREEN_BITMAP_RAM_START = $4000
SCREEN_BITMAP_RAM_END = $57ff

; screen color attributes 32x24, 768B
SCREEN_COLOR_RAM_START = $5800
SCREEN_COLOR_RAM_END = $5aff

; printer buffer
PRINTER_BUFFER = $5be0

TEST_23346 = $5b32
TEST_23347 = $5b33

ENTER = $0D

ROM_FONT_ADDR_POINTER = $5C36 ; contains address of system fonts, standard is $3d00
ROM_FONT_ADDR = $3d00

    endmodule