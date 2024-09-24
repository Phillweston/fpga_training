onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/temp_data
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/sys_rst_n
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/sys_clk
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/sclk_last_2
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/sclk_last
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/sclk_falling_edge_reg
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/sclk_falling_edge
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/rec_flag
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/rec_data
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/ps2_sda
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/ps2_sclk
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/long_code_flag
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/key_value
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/cnt
add wave -noupdate /ps2_drive_tb/ps2_drive_inst/break_code_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {733643600 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {3173253120 ps}
