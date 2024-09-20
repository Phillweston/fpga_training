
	#set_global_assignment -name FAMILY "Cyclone IV"
	#set_global_assignment -name DEVICE ep4ce6e22c8n

set_location_assignment PIN_23 -to    clk 	

# SEG7 x 8 Æß¶ÎÊýÂë¹Ü
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

        
# KEY Çá´¥°´¼ü
set_location_assignment PIN_69 -to   key_freq_add         
set_location_assignment PIN_70 -to   key_freq_sub        
set_location_assignment PIN_71 -to   key_a         
set_location_assignment PIN_72 -to   key_wave

# DA
set_location_assignment PIN_86 -to  da_sda
set_location_assignment PIN_85 -to  da_clk       
set_location_assignment PIN_84 -to  da_ldac 
set_location_assignment PIN_83 -to  da_load         
         

     
 