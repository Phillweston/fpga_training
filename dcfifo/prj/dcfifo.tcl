
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6f17c8n

set_location_assignment PIN_E1    -to    sys_clk

# KEY 轻触按键
set_location_assignment PIN_N13    -to   sys_rst_n

set_location_assignment PIN_R14    -to   rd_data[0]
set_location_assignment PIN_N16    -to   rd_data[1]
set_location_assignment PIN_P16    -to   rd_data[2]
set_location_assignment PIN_T15    -to   rd_data[3]
set_location_assignment PIN_P15    -to   rd_data[4]
set_location_assignment PIN_N12    -to   rd_data[5]
set_location_assignment PIN_N15    -to   rd_data[6]
set_location_assignment PIN_R16    -to   rd_data[7]