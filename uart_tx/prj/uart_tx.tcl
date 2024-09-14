
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to    sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3    -to   sys_rst_n

# KEY_BORD
set_location_assignment PIN_L15   -to   col[0]
set_location_assignment PIN_N15   -to   col[1]
set_location_assignment PIN_P15   -to   col[2]
set_location_assignment PIN_T15   -to   col[3]
set_location_assignment PIN_R14   -to   row[0]
set_location_assignment PIN_R16   -to   row[1]
set_location_assignment PIN_P16   -to   row[2]
set_location_assignment PIN_N16   -to   row[3]

# UART
set_location_assignment PIN_K2    -to    txd