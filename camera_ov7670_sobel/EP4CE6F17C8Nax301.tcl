
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6f17c8n

set_location_assignment PIN_E1 -to pi_clk
	
#sys_rst_n
set_location_assignment PIN_N13 -to pi_rst_n
	
# VGA 565
set_location_assignment PIN_L6 -to po_vga_hs
set_location_assignment PIN_N3 -to po_vga_vs
set_location_assignment PIN_L4 -to po_vga_rgb[15]
set_location_assignment PIN_L3 -to po_vga_rgb[14]
set_location_assignment PIN_L7 -to po_vga_rgb[13]
set_location_assignment PIN_K5 -to po_vga_rgb[12]
set_location_assignment PIN_K6 -to po_vga_rgb[11]
set_location_assignment PIN_J6 -to po_vga_rgb[10]
set_location_assignment PIN_L8 -to po_vga_rgb[9]
set_location_assignment PIN_K8 -to po_vga_rgb[8]
set_location_assignment PIN_F7 -to po_vga_rgb[7]
set_location_assignment PIN_G5 -to po_vga_rgb[6]
set_location_assignment PIN_F5 -to po_vga_rgb[5]
set_location_assignment PIN_F6 -to po_vga_rgb[4]
set_location_assignment PIN_E5 -to po_vga_rgb[3]
set_location_assignment PIN_D3 -to po_vga_rgb[2]
set_location_assignment PIN_D4 -to po_vga_rgb[1]
set_location_assignment PIN_C3 -to po_vga_rgb[0]
        
# SDRAM
set_location_assignment PIN_B14 -to po_sdram_clk
set_location_assignment PIN_K10 -to po_sdram_cs_n
set_location_assignment PIN_F16 -to po_sdram_cke
set_location_assignment PIN_J13 -to po_sdram_we_n
set_location_assignment PIN_K11 -to po_sdram_ras_n
set_location_assignment PIN_J12 -to po_sdram_cas_n
set_location_assignment PIN_J14 -to po_sdram_dqm[0]
set_location_assignment PIN_G15 -to po_sdram_dqm[1]
set_location_assignment PIN_G11 -to po_sdram_bank[0]
set_location_assignment PIN_F13 -to po_sdram_bank[1]
set_location_assignment PIN_F11 -to po_sdram_addr[0]
set_location_assignment PIN_E11 -to po_sdram_addr[1]
set_location_assignment PIN_D16 -to po_sdram_addr[11]
set_location_assignment PIN_F14 -to po_sdram_addr[10]
set_location_assignment PIN_D15 -to po_sdram_addr[9]
set_location_assignment PIN_C16 -to po_sdram_addr[8]
set_location_assignment PIN_C15 -to po_sdram_addr[7]
set_location_assignment PIN_B16 -to po_sdram_addr[6]
set_location_assignment PIN_A15 -to po_sdram_addr[5]
set_location_assignment PIN_A14 -to po_sdram_addr[4]
set_location_assignment PIN_C14 -to po_sdram_addr[3]
set_location_assignment PIN_D14 -to po_sdram_addr[2]
set_location_assignment PIN_L15 -to pio_sdram_dq[15]
set_location_assignment PIN_L16 -to pio_sdram_dq[14]
set_location_assignment PIN_K15 -to pio_sdram_dq[13]
set_location_assignment PIN_K16 -to pio_sdram_dq[12]
set_location_assignment PIN_J15 -to pio_sdram_dq[11]
set_location_assignment PIN_J16 -to pio_sdram_dq[10]
set_location_assignment PIN_J11 -to pio_sdram_dq[9]
set_location_assignment PIN_G16 -to pio_sdram_dq[8]
set_location_assignment PIN_K12 -to pio_sdram_dq[7]
set_location_assignment PIN_L11 -to pio_sdram_dq[6]
set_location_assignment PIN_L14 -to pio_sdram_dq[5]
set_location_assignment PIN_L13 -to pio_sdram_dq[4]
set_location_assignment PIN_L12 -to pio_sdram_dq[3]
set_location_assignment PIN_N14 -to pio_sdram_dq[2]
set_location_assignment PIN_M12 -to pio_sdram_dq[1]
set_location_assignment PIN_P14 -to pio_sdram_dq[0]

# CMOS 
set_location_assignment PIN_F2 -to pi_cmos_hs
set_location_assignment PIN_M1 -to pi_cmos_pclk
set_location_assignment PIN_G1 -to pi_cmos_vs
set_location_assignment PIN_J2 -to pi_coms_pdata[7]
set_location_assignment PIN_J1 -to pi_coms_pdata[6]
set_location_assignment PIN_K2 -to pi_coms_pdata[5]
set_location_assignment PIN_K1 -to pi_coms_pdata[4]
set_location_assignment PIN_L2 -to pi_coms_pdata[3]
set_location_assignment PIN_L1 -to pi_coms_pdata[2]
set_location_assignment PIN_N5 -to pi_coms_pdata[1]
set_location_assignment PIN_M6 -to pi_coms_pdata[0]
set_location_assignment PIN_F3 -to pio_cmos_sccb_sda
set_location_assignment PIN_F1 -to po_cmos_sccb_scl
set_location_assignment PIN_G2 -to po_cmos_xclk
set_location_assignment PIN_N6 -to po_cmos_rst
set_location_assignment PIN_M7 -to po_cmos_pwnd


set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"

