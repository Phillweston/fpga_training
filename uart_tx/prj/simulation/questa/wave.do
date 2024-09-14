onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_transmitter_tb/sys_clk
add wave -noupdate /uart_transmitter_tb/sys_rst_n
add wave -noupdate /uart_transmitter_tb/key_num
add wave -noupdate /uart_transmitter_tb/row
add wave -noupdate /uart_transmitter_tb/col
add wave -noupdate /uart_transmitter_tb/txd
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/wrreq
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/wrfull
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/wrclk
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/sub_wire2
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/sub_wire1
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/sub_wire0
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/rdreq
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/rdempty
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/rdclk
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/q
add wave -noupdate -group tx_fifo /uart_transmitter_tb/uart_transmitter_inst/tx_fifo_inst/data
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/uart_clk
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/txd
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/temp_data
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/sys_rst_n
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/state
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/send_data_flag
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/send_data
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/s1
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/s0
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/rd_req
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/rd_empty
add wave -noupdate -expand -group uart_tx_v1 /uart_transmitter_tb/uart_transmitter_inst/uart_tx_v1_inst/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99556538 ps} 0}
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
WaveRestoreZoom {0 ps} {2097152 ns}
