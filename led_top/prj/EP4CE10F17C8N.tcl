
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce10f17c8n

set_location_assignment PIN_E1    -to    clk

# LED
set_location_assignment PIN_T12   -to   LED[0]
set_location_assignment PIN_P8    -to   LED[1]
set_location_assignment PIN_M8    -to   LED[2]
set_location_assignment PIN_M10   -to   LED[3]