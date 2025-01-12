#!/bin/zsh

# Check if a parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <program_name>"
    exit 1
fi

# Get the program name from the first argument
PROGRAM_NAME="$1"

# File used in LBYTES
LBYTES_FILE="${PROGRAM_NAME}_bin"

# Check if the file used in LBYTES exists
if [ ! -f "$LBYTES_FILE" ]; then
    echo "Error: File '${LBYTES_FILE}' not found."
    exit 1
fi

# Text to generate
TEXT="10 start=RESPR(32768)\n20 LBYTES mdv1_${LBYTES_FILE},start\n30 CALL start"

# Output file name
OUTPUT_FILE="${PROGRAM_NAME}_bas"

# Write text to file
echo -e $TEXT > $OUTPUT_FILE

# Confirm the output
if [ -f "$OUTPUT_FILE" ]; then
    echo "File '${OUTPUT_FILE}' successfully created!"
else
    echo "Error: Failed to create '${OUTPUT_FILE}'."
fi