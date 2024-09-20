
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6e22c8n

set_location_assignment PIN_23 -to  sys_clk

# KEY 轻触按键
set_location_assignment PIN_69 -to  sys_rst_n
set_location_assignment PIN_70 -to  key_in

# DA
set_location_assignment PIN_99 -to  ad_io_clock
set_location_assignment PIN_87 -to  ad_data_out
set_location_assignment PIN_98 -to  ad_cs_n

# LED
set_location_assignment PIN_136 -to   led

# SEG7 x 8 七段数码管
set_location_assignment PIN_119 -to   sel[2]
set_location_assignment PIN_115 -to   sel[1]
set_location_assignment PIN_114 -to   sel[0]
set_location_assignment PIN_127 -to   seg[0]
set_location_assignment PIN_128 -to   seg[1]
set_location_assignment PIN_124 -to   seg[2]
set_location_assignment PIN_121 -to   seg[3]
set_location_assignment PIN_120 -to   seg[4]
set_location_assignment PIN_126 -to   seg[5]
set_location_assignment PIN_129 -to   seg[6]
set_location_assignment PIN_125 -to   seg[7]
