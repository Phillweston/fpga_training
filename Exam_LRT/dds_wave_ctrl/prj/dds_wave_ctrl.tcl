
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to   sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3    -to   sys_rst_n
set_location_assignment PIN_L1    -to   key_switch
set_location_assignment PIN_J6    -to   key_mode
set_location_assignment PIN_N1    -to   key_add
set_location_assignment PIN_N2    -to   key_sub

# SEG7 x 8 七段数码管
set_location_assignment PIN_T11   -to   q[0]
set_location_assignment PIN_T10   -to   q[1]
set_location_assignment PIN_T9    -to   q[2]
set_location_assignment PIN_T8    -to   q[3]
set_location_assignment PIN_T7    -to   q[4]
set_location_assignment PIN_T6    -to   q[5]
set_location_assignment PIN_T5    -to   q[6]
set_location_assignment PIN_T4    -to   q[7]