#!/bin/bash

input="./code.s"
hexFile="./dump.hex"
output="./quartus-project/program.mif"

# Assemble the instructions and dump them into a temporary file
java -jar ./RARS.jar a dump .text HexText "$hexFile" "$input"

# Generate the .mif file
echo "WIDTH=32;" > "$output"
echo "DEPTH=256;" >> "$output"
echo "ADDRESS_RADIX=HEX;" >> "$output"
echo "DATA_RADIX=HEX;" >> "$output"

echo "" >> "$output"

echo "CONTENT BEGIN" >> "$output"

i=0
while IFS= read -r line 
do 
    # echo "    $i : $line;" >> "$output"
    printf "\t%x : ${line::-1};\n" "$i" >> "$output"
    i=$((i+1))
done < "$hexFile"

echo "END;" >> "$output"


rm "$hexFile"