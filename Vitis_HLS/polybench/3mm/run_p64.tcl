#vitis_hls -f run_p64.tcl
open_project posit64
if { $argc < 3 } { # default value
    set clk_period 20
} else {
    set clk_period [lindex $argv 2]
}
if { $argc < 4 } { # default value
    set DATASET_SIZE MINI
} else {
    set DATASET_SIZE [lindex $argv 3]
}
add_files "main.cpp" -cflags "-I./. -I./.. -I/homelocal/raul_local/Documents/libs/marto/include -I/homelocal/raul_local/Documents/libs/hint/include -O3 -D${DATASET_SIZE}_DATASET -DDATA_TYPE_IS_POSIT64 -DPOLYBENCH_USE_SCALAR_LB"
open_solution "solution_${clk_period}" -flow_target vivado -reset
set_top main_kernel
set_part {xc7a100tcsg324-1}
create_clock -period ${clk_period} -name default
#set_clock_uncertainty 0
#set_directive_top -name main_kernel "main_kernel"
#csim_design
csynth_design
#cosim_design
#export_design -flow syn -rtl verilog -format ip_catalog
exit
