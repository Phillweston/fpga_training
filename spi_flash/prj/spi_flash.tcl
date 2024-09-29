
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6e22c8n

set_location_assignment PIN_E1  -to  sys_clk

# KEY 轻触按键
set_location_assignment PIN_L3  -to  sys_rst_n

# SPI flash pins
set_location_assignment PIN_D2  -to  spi_cs_n
set_location_assignment PIN_H1  -to  spi_sck
set_location_assignment PIN_C1  -to  spi_mosi
set_location_assignment PIN_H2  -to  spi_miso