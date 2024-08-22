set_global_assignment -name FAMILY "Cyclone IV"
set_global_assignment -name DEVICE ep4ce10f17c8

set_location_assignment PIN_E1    -to    sys_clk
set_location_assignment PIN_L3    -to    sys_rst_n
set_location_assignment PIN_L1    -to    key_pause
set_location_assignment PIN_J6    -to    key_switch
set_location_assignment PIN_R14    -to    row_in[0]
set_location_assignment PIN_R16    -to    row_in[1]
set_location_assignment PIN_P16    -to    row_in[2]
set_location_assignment PIN_N16    -to    row_in[3]
set_location_assignment PIN_L15    -to    col_in[0]
set_location_assignment PIN_N15    -to    col_in[1]
set_location_assignment PIN_P15    -to    col_in[2]
set_location_assignment PIN_T15    -to    col_in[3]

# LED Tube 7
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