onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_receiver_tb/sys_clk
add wave -noupdate /uart_receiver_tb/sys_rst_n
add wave -noupdate /uart_receiver_tb/rxd
add wave -noupdate /uart_receiver_tb/key_in
add wave -noupdate /uart_receiver_tb/sel
add wave -noupdate /uart_receiver_tb/seg
add wave -noupdate /uart_receiver_tb/led
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {361190000 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {265350877 ps} {396422877 ps}
