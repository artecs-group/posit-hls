#!/bin/bash

for format in float32 float64
do
    cd ${format}
    # # # rm -r synth*
    for period in 20 10 6.66667 5 4 3.3333 # Freq 50 100 150 200 250 300 MHz
    do
        ./bambu.sh ${period} 2>&1 | tail -n 16 > results_${period}.txt
    done
    cd ..
done