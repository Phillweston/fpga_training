
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6e22c8n

set_location_assignment PIN_23 -to  sys_clk

# KEY 轻触按键
set_location_assignment PIN_69 -to  sys_rst_n

# DA
set_location_assignment PIN_86 -to  tlc5620_data
set_location_assignment PIN_85 -to  tlc5620_clk
set_location_assignment PIN_84 -to  tlc5620_ldac
set_location_assignment PIN_83 -to  tlc5620_load
