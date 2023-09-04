#vitis_hls -f run_f32.tcl
open_project float32
if { $argc != 3 } { # default value
    set clk_period 15
} else {
    set clk_period [lindex $argv 2]
}
add_files mult.cpp -cflags "-I./float32 -O3"
open_solution "solution_${clk_period}" -flow_target vivado -reset
set_top mult
set_part {xc7a100tcsg324-1}
create_clock -period $clk_period -name default
#set_clock_uncertainty 0
set_directive_top -name mult "mult"
#csim_design
csynth_design
#cosim_design
#export_design -flow syn -rtl verilog -format ip_catalog
exit
