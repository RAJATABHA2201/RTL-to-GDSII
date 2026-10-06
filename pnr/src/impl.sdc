create_clock -name clk -period 10 [get_ports clk]

set_input_delay 0 -clock clk [get_ports {a[*] b[*] rst_n}]
set_output_delay 0 -clock clk [get_ports {p[*]}]

set_clock_uncertainty 0.1 [get_clocks clk]

set_max_fanout 10 [current_design]
