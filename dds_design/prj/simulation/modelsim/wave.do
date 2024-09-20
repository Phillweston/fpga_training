onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /key_handle_tb/clk
add wave -noupdate /key_handle_tb/rst_n
add wave -noupdate /key_handle_tb/key_freq_add
add wave -noupdate /key_handle_tb/key_freq_sub
add wave -noupdate /key_handle_tb/key_a
add wave -noupdate /key_handle_tb/key_wave
add wave -noupdate /key_handle_tb/wave_flag
add wave -noupdate /key_handle_tb/key_freq_add_flag
add wave -noupdate /key_handle_tb/key_freq_sub_flag
add wave -noupdate /key_handle_tb/key_a_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4261511 ps} 0}
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
WaveRestoreZoom {0 ps} {30660 ns}
