set_global_assignment -name FAMILY "Cyclone IV"
set_global_assignment -name DEVICE ep4ce10f17c8

set_location_assignment PIN_E1    -to    sys_clk
set_location_assignment PIN_L3    -to    sys_rst_n

# LED
set_location_assignment PIN_T12   -to   led[0]
set_location_assignment PIN_P8    -to   led[1]
set_location_assignment PIN_M8    -to   led[2]
set_location_assignment PIN_M10   -to   led[3]