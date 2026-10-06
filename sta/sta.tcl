read_liberty /foss/pdks/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog synth/mult_array_netlist.v

link_design mult_array

create_clock -name clk -period 10 [get_ports clk]

set_input_delay 0 -clock clk [get_ports {a[*] b[*] rst_n}]
set_output_delay 0 -clock clk [get_ports {p[*]}]

report_checks -path_delay max -format full_clock_expanded > sta/mult_array_timing.rpt

report_wns
report_tns
