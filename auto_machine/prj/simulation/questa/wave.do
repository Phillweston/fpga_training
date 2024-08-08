onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /auto_machine_v3_tb/sys_clk
add wave -noupdate -radix binary /auto_machine_v3_tb/sys_rst_n
add wave -noupdate -radix binary /auto_machine_v3_tb/one_rmb
add wave -noupdate -radix binary /auto_machine_v3_tb/one_rmb_half
add wave -noupdate -radix binary /auto_machine_v3_tb/drink
add wave -noupdate -radix binary /auto_machine_v3_tb/change
add wave -noupdate -radix binary /auto_machine_v3_tb/auto_machine_v3_inst/current_state
add wave -noupdate -radix binary /auto_machine_v3_tb/auto_machine_v3_inst/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {949504 ps} 0}
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
WaveRestoreZoom {512 ns} {1536 ns}
