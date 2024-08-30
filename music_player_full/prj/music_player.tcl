
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to   sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3    -to   sys_rst_n

#BEEP 蜂鸣器                      
set_location_assignment PIN_P9    -to    beep