#!/bin/bash
script=$(readlink -e $0)
root_dir=$(dirname $script)
vhdl_dir=$root_dir/../../common_vhdl
export PATH=../../src:../../../src:${HOME}/panda_bambu/float_version/panda/bin:$PATH
period=${1:-20}

if [ ! -d "synth_${period}" ]; then
  echo "synth_${period} does not exist."
  exit 1
fi

# rm -rf synth_${period}
# mkdir -p synth_${period}
cd synth_${period}
echo "# HLS synthesis, testbench generation and simulation with XSIM and RTL synthesis with Xilinx Vivado"

   # --file-input-data=$vhdl_dir/my_sqrt_float_32_100.vhd \
bambu -v3 -O3 -lm $root_dir/../sqrt.c --top-fname=sqrt_op -I$root_dir \
   --generate-tb=$root_dir/../test.xml --simulator=XSIM \
   $root_dir/synth_${period}/my_sqrt_lib.xml \
   --C-no-parse=$root_dir/../my_sqrt.c \
   --evaluation \
   --pretty-print=main.c \
   --device-name=xc7a100t-1csg324-VVD --experimental-setup=VVD --no-iob \
   --clock-period=${period} --flopoco=float
return_value=$?
if test $return_value != 0; then
   exit $return_value
fi
cd ..

exit 0
