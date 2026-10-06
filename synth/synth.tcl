read_verilog rtl/full_adder.v
read_verilog rtl/mult_array.v

synth -top mult_array -flatten

dfflibmap -liberty /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

abc -liberty /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

opt_clean -purge

tee -o synth/mult_array_stat.rpt stat -liberty /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

write_verilog -noattr synth/mult_array_netlist.v
