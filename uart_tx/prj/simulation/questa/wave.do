onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_tx_v1_tb/uart_clk
add wave -noupdate /uart_tx_v1_tb/sys_rst_n
add wave -noupdate /uart_tx_v1_tb/send_data
add wave -noupdate /uart_tx_v1_tb/txd
add wave -noupdate /uart_tx_v1_tb/send_data_flag
add wave -noupdate -radix binary /uart_tx_v1_tb/data_temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1561236160 ps} 0}
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
WaveRestoreZoom {1087372900 ps} {2135948900 ps}
