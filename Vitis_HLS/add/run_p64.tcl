#vitis_hls -f run_p64.tcl
open_project posit64
if { $argc != 3 } { # default value
    set clk_period 15
} else {
    set clk_period [lindex $argv 2]
}
set_top add
add_files add.cpp -cflags "-I./posit64 -I/homelocal/raul_local/Documents/libs/marto/include -I/homelocal/raul_local/Documents/libs/hint/include -O3"
open_solution "solution_${clk_period}" -flow_target vivado -reset
set_part {xc7a100tcsg324-1}
create_clock -period $clk_period -name default
#set_clock_uncertainty 0
set_directive_top -name add "add"
#csim_design
csynth_design
#cosim_design
#export_design -flow syn -rtl verilog -format ip_catalog
exit
