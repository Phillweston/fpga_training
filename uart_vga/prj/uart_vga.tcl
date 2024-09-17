
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to    sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3    -to   sys_rst_n
set_location_assignment PIN_L1    -to   key_in

# UART
set_location_assignment PIN_K5    -to   rxd

# 256色VGA 
set_location_assignment PIN_A7    -to  vga_vsync
set_location_assignment PIN_A6    -to  vga_hsync
set_location_assignment PIN_C6    -to  vga_rgb[1]
set_location_assignment PIN_B5    -to  vga_rgb[0]
set_location_assignment PIN_E5    -to  vga_rgb[4]
set_location_assignment PIN_A4    -to  vga_rgb[3]
set_location_assignment PIN_D4    -to  vga_rgb[2]
set_location_assignment PIN_C3    -to  vga_rgb[7]
set_location_assignment PIN_B1    -to  vga_rgb[6]
set_location_assignment PIN_E8    -to  vga_rgb[5]

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