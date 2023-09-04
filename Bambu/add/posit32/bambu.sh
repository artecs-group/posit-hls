#!/bin/bash
script=$(readlink -e $0)
root_dir=$(dirname $script)
vhdl_dir=$root_dir/../../common_vhdl
export PATH=../../src:../../../src:${HOME}/panda_bambu/posit_version/panda/bin:$PATH
period=${1:-20}

rm -rf synth_${period}
mkdir -p synth_${period}
cd synth_${period}
echo "# HLS synthesis, testbench generation and simulation with XSIM and RTL synthesis with Xilinx Vivado"

bambu -v3 -O3 $root_dir/../add.c --top-fname=add -I$root_dir \
   --generate-tb=$root_dir/../test.xml --simulator=XSIM \
   --evaluation \
   --pretty-print=a.c \
   --device-name=xc7a100t-1csg324-VVD --experimental-setup=VVD --no-iob \
   --clock-period=${period} --flopoco=posit
return_value=$?
if test $return_value != 0; then
   # Posit-based computation is supposed to fail, since test is done in FP
   ./synthesize_Synthesis_add.sh
   echo $(grep "Simulation ended after" HLS_output/modelsim_beh/add_modelsim.log)
   cat HLS_output/Synthesis/vivado_flow/add_report.xml
   exit $return_value
fi
cd ..

exit 0
