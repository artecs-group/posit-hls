#!/bin/bash
script=$(readlink -e $0)
root_dir=$(dirname $script)
# vhdl_dir=$root_dir/../../common_vhdl
export PATH=../../src:../../../src:${HOME}/panda_bambu/posit_version/panda/bin:$PATH
period=${1:-20}
DATASET_SIZE=${2:-MINI}

rm -rf synth_${period}_${DATASET_SIZE}
mkdir -p synth_${period}_${DATASET_SIZE}
cd synth_${period}_${DATASET_SIZE}
echo "# HLS synthesis, testbench generation and simulation with MODELSIM and RTL synthesis with Xilinx Vivado"

bambu -v3 -O3 $root_dir/../main.c $root_dir/../cholesky.c --top-fname=main_kernel \
   -I$root_dir -I$root_dir/.. -I$root_dir/../.. \
   $root_dir/my_sqrt_lib_${period}.xml \
   --C-no-parse=$root_dir/../my_sqrt.c \
   -D${DATASET_SIZE}_DATASET -DDATA_TYPE_IS_DOUBLE -DPOLYBENCH_USE_SCALAR_LB \
   --generate-tb=$root_dir/../test_${DATASET_SIZE}.xml --simulator=MODELSIM \
   --evaluation \
   --pretty-print=a.c \
   --device-name=xc7a100t-1csg324-VVD --experimental-setup=VVD --no-iob \
   --clock-period=${period} --flopoco=posit
return_value=$?
if test $return_value != 0; then
   # Posit-based computation is supposed to fail, since test is done in FP
   ./synthesize_Synthesis_main_kernel.sh
   echo $(grep "Simulation ended after" HLS_output/modelsim_beh/main_kernel_modelsim.log)
   # cat HLS_output/Synthesis/vivado_flow/main_kernel_report.xml
   tail -n 13 HLS_output/Synthesis/vivado_flow/main_kernel_report.xml | head -n 11
   # exit $return_value
fi
cd ..

exit 0
