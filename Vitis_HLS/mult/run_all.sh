#!/bin/bash
source /opt/Xilinx/Vitis_HLS/2021.2/settings64.sh

# for script in run_f32.tcl run_f64.tcl run_p32.tcl run_p64.tcl
for script in run_p32.tcl
do
   for period in 20 10 6.66667 5 4 3.3333
   do
      vitis_hls -f $script ${period}
   done
done

# Collect results
# for data_t in float32 float64 posit32 posit64
for data_t in posit32
do
   for period in 20 10 6.66667 5 4 3.3333
   do
      printf "\n--- ${data_t} - ${period} ns ---\n" >> results.txt
      python ../get_results.py "${data_t}/solution_${period}/syn/report/csynth.xml" >> results.txt
   done
done