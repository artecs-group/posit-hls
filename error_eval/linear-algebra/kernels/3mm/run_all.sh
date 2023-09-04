#!/bin/sh

mkdir -p ../../../results/outputs/3mm/

# Print output results
for size in MINI SMALL MEDIUM LARGE
do
    # for type in float double longdouble posit32 posit64
    for type in posit_mem_float posit_mem_double
    do
        ./3mm_${type}_${size}.elf | tail -n +3 | head -n -2  > ../../../results/outputs/3mm/3mm_${type}_${size}.txt
    done
done