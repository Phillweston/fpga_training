
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to    sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3    -to   sys_rst_n
set_location_assignment PIN_L1    -to   key_switch
set_location_assignment PIN_J6    -to   key_zoom_in
set_location_assignment PIN_N1    -to   key_zoom_out

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