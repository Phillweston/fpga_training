create_generated_clock -name clk_0p25mhz_dev4 -source [get_pins clock_constraints_ins/pll_inst/clk_out2] -divide_by 4 -add -master_clock clk_out2_pll [get_pins clock_constraints_ins/clk_0p25mhz_reg/Q]
create_generated_clock -name clk_115200hz_o -source [get_pins clock_constraints_ins/pll_inst/clk_out2] -divide_by 217 -add -master_clock clk_out1_pll [get_pins logi_enty_ins/clk_115200hz_reg/Q]
create_clock -period 40.000 -name my_scl -waveform {0.000 20.000} [get_ports -regexp -filter { NAME =~  ".*scl.*" && DIRECTION == "IN" }]
set_false_path -from [get_clocks my_scl] -to [get_clocks clk_115200hz_o]
set_multicycle_path -setup -rise -start -from [get_ports -regexp .*din.*] -to [get_ports -regexp .*dout.*] 2
set_multicycle_path -setup -rise -end -from [get_ports -regexp .*din.*] -to [get_ports -regexp .*dout.*] 1
set_input_delay -clock [get_clocks my_scl] -rise -min 2.000 [get_ports -regexp -filter { NAME =~  ".*sda.*" && DIRECTION == "IN" }]
set_input_delay -clock [get_clocks my_scl] -rise -max 6.000 [get_ports -regexp -filter { NAME =~  ".*sda.*" && DIRECTION == "IN" }]
set_output_delay -clock [get_clocks clk_115200hz_o] -rise -min 3.000 [get_ports -regexp -filter { NAME =~  ".*tx.*" && DIRECTION == "OUT" }]
set_output_delay -clock [get_clocks clk_115200hz_o] -rise -max 8.000 [get_ports -regexp -filter { NAME =~  ".*tx.*" && DIRECTION == "OUT" }]
