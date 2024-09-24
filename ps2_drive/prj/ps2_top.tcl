
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to    sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3    -to    sys_rst_n

# PS2
set_location_assignment PIN_N8    -to    ps2_sclk
set_location_assignment PIN_L8    -to    ps2_sda

# BEEP 蜂鸣器
set_location_assignment PIN_P9    -to    beep

# SEG7 x 8 七段数码管
set_location_assignment PIN_L6    -to   sel[2]
set_location_assignment PIN_N6    -to   sel[1]
set_location_assignment PIN_M7    -to   sel[0]
set_location_assignment PIN_T11   -to   seg[0]
set_location_assignment PIN_T10   -to   seg[1]
set_location_assignment PIN_T9    -to   seg[2]
set_location_assignment PIN_T8    -to   seg[3]
set_location_assignment PIN_T7    -to   seg[4]
set_location_assignment PIN_T6    -to   seg[5]
set_location_assignment PIN_T5    -to   seg[6]
set_location_assignment PIN_T4    -to   seg[7]