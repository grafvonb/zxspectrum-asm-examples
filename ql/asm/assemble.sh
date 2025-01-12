#!/bin/zsh

# Check if a filename is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename_without_extension>"
    exit 1
fi

# Extract the base name without .asm
BASENAME="$1"
ASM_FILE="${BASENAME}.asm"
BIN_FILE="${BASENAME}_bin"
LST_FILE="${BASENAME}_lst.txt"

# Check if the .asm file exists
if [ ! -f "$ASM_FILE" ]; then
    echo "Error: File '$ASM_FILE' not found."
    exit 1
fi

# Assemble the .asm file into a binary
echo "Assembling $ASM_FILE into $BIN_FILE..."
vasm -Fbin -chklabels -nocase -L "lst/$LST_FILE" -o "$BIN_FILE" "$ASM_FILE"
if [ $? -ne 0 ]; then
    echo "Error: Assembly failed."
    exit 1
fi
echo "Done"
exit 0
