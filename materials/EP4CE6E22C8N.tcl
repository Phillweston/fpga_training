
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6e22c8n

set_location_assignment PIN_23 -to    clk

# UART
set_location_assignment PIN_76 -to    rs232_rx
set_location_assignment PIN_75 -to    rs232_tx

# LED
set_location_assignment PIN_136 -to   LED[0]
set_location_assignment PIN_135 -to   LED[1]
set_location_assignment PIN_133 -to   LED[2]
set_location_assignment PIN_132 -to   LED[3]

# PS2
set_location_assignment PIN_80 -to    ps2_sclk
set_location_assignment PIN_77 -to    ps2_sda

# BEEP 蜂鸣器
set_location_assignment PIN_68 -to    beep

# 256色VGA
set_location_assignment PIN_112 -to  vga_vs
set_location_assignment PIN_113 -to  vga_hs
set_location_assignment PIN_100 -to  vga_b[1]
set_location_assignment PIN_101 -to  vga_b[0]
set_location_assignment PIN_104 -to  vga_g[2]
set_location_assignment PIN_103 -to  vga_g[1]
set_location_assignment PIN_105 -to  vga_g[0]
set_location_assignment PIN_106 -to  vga_r[2]
set_location_assignment PIN_110 -to  vga_r[1]
set_location_assignment PIN_111 -to  vga_r[0]

# KEY 轻触按键
set_location_assignment PIN_69 -to   key[0]
set_location_assignment PIN_70 -to   key[1]
set_location_assignment PIN_71 -to   key[2]
set_location_assignment PIN_72 -to   key[3]

# EEPROM
set_location_assignment PIN_73 -to   eeprom_scl
set_location_assignment PIN_74 -to   eeprom_sda

# AD
set_location_assignment PIN_99 -to  ad_clk
set_location_assignment PIN_87 -to  ad_dat
set_location_assignment PIN_98 -to  ad_cs

# DA
set_location_assignment PIN_86 -to  da_data
set_location_assignment PIN_85 -to  da_clk
set_location_assignment PIN_84 -to  da_ldac
set_location_assignment PIN_83 -to  da_load

# SEG7 x 8 七段数码管
set_location_assignment PIN_119 -to   sel[2]
set_location_assignment PIN_115 -to   sel[1]
set_location_assignment PIN_114 -to   sel[0]
set_location_assignment PIN_127 -to   seg[0]
set_location_assignment PIN_128 -to   seg[1]
set_location_assignment PIN_124 -to   seg[2]
set_location_assignment PIN_121 -to   seg[3]
set_location_assignment PIN_120 -to   seg[4]
set_location_assignment PIN_126 -to   seg[5]
set_location_assignment PIN_129 -to   seg[6]
set_location_assignment PIN_125 -to   seg[7]

# SDRAM
set_location_assignment PIN_64 -to a[0]
set_location_assignment PIN_65 -to a[1]
set_location_assignment PIN_66 -to a[2]
set_location_assignment PIN_67 -to a[3]
set_location_assignment PIN_34 -to a[4]
set_location_assignment PIN_33 -to a[5]
set_location_assignment PIN_32 -to a[6]
set_location_assignment PIN_31 -to a[7]
set_location_assignment PIN_30 -to a[8]
set_location_assignment PIN_28 -to a[9]
set_location_assignment PIN_60 -to a[10]
set_location_assignment PIN_11 -to a[11]
set_location_assignment PIN_58 -to ba[0]
set_location_assignment PIN_59 -to ba[1]
set_location_assignment PIN_51 -to dom[1]
set_location_assignment PIN_3  -to dom[0]
set_location_assignment PIN_10 -to scke
set_location_assignment PIN_7  -to sclk
set_location_assignment PIN_52 -to nwe
set_location_assignment PIN_53 -to nscas
set_location_assignment PIN_54 -to ncras
set_location_assignment PIN_55 -to nscs
set_location_assignment PIN_38 	-to dq[0]
set_location_assignment PIN_39 	-to dq[1]
set_location_assignment PIN_42  -to dq[2]
set_location_assignment PIN_43  -to dq[3]
set_location_assignment PIN_44  -to dq[4]
set_location_assignment PIN_46  -to dq[5]
set_location_assignment PIN_49  -to dq[6]
set_location_assignment PIN_50  -to dq[7]
set_location_assignment PIN_2   -to dq[8]
set_location_assignment PIN_1   -to dq[9]
set_location_assignment PIN_144 -to dq[10]
set_location_assignment PIN_143 -to dq[11]
set_location_assignment PIN_142 -to dq[12]
set_location_assignment PIN_141 -to dq[13]
set_location_assignment PIN_138 -to dq[14]
set_location_assignment PIN_137 -to dq[15]
