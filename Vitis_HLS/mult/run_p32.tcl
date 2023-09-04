#vitis_hls -f run_p32.tcl
open_project posit32
if { $argc != 3 } { # default value
    set clk_period 15
} else {
    set clk_period [lindex $argv 2]
}
add_files mult.cpp -cflags "-I./posit32 -I/homelocal/raul_local/Documents/libs/marto/include -I/homelocal/raul_local/Documents/libs/hint/include -O3"
open_solution "solution_${clk_period}" -flow_target vivado -reset
set_top mult
set_part {xc7a100tcsg324-1}
create_clock -period $clk_period -name default
#set_clock_uncertainty 0
# set_directive_top -name mult "mult"
###
## set_directive_dataflow mult
# config_export -vivado_phys_opt all -vivado_synth_design_args "-directive sdx_optimization_effort_high -mode out_of_context -no_iobuf"
###
#csim_design
csynth_design
#cosim_design
#export_design -flow syn -rtl verilog -format ip_catalog
exit
