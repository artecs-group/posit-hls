#!/bin/bash
script=$(readlink -e $0)
root_dir=$(dirname $script)
# vhdl_dir=$root_dir/../../../common_vhdl
export PATH=../../src:../../../src:${HOME}/panda_bambu/float_version/panda/bin:$PATH
period=${1:-20}
DATASET_SIZE=${2:-MINI}
if (( $(echo "$period < 10" | bc -l) )); then
    # Period is less than 10
    converters_lib=$root_dir/converters_lib_fast.xml
else
    # Period is greater than or equal to 10
    converters_lib=$root_dir/converters_lib.xml
fi

rm -rf synth_${period}_${DATASET_SIZE}
mkdir -p synth_${period}_${DATASET_SIZE}
cd synth_${period}_${DATASET_SIZE}
echo "# HLS synthesis, testbench generation and simulation with MODELSIM and RTL synthesis with Xilinx Vivado"

bambu -v3 -O3 $root_dir/../main.c $root_dir/../durbin.c --top-fname=main_kernel \
   $converters_lib \
   -DPOSIT_MEM \
   --C-no-parse=$root_dir/posit2float.c,$root_dir/float2posit.c \
   -I$root_dir -I$root_dir/.. -I$root_dir/../.. \
   -D${DATASET_SIZE}_DATASET -DDATA_TYPE_IS_DOUBLE -DPOLYBENCH_USE_SCALAR_LB \
   --generate-tb=$root_dir/../test_${DATASET_SIZE}.xml --simulator=MODELSIM \
   --evaluation \
   --pretty-print=a.c \
   --device-name=xc7a100t-1csg324-VVD --experimental-setup=VVD --no-iob \
   --clock-period=${period} --flopoco=float
return_value=$?
if test $return_value != 0; then
   exit $return_value
fi
cd ..

exit 0
