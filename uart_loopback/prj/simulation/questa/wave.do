onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_loopback_tb/txd
add wave -noupdate /uart_loopback_tb/sys_rst_n
add wave -noupdate /uart_loopback_tb/sys_clk
add wave -noupdate /uart_loopback_tb/sel
add wave -noupdate /uart_loopback_tb/seg
add wave -noupdate /uart_loopback_tb/rxd
add wave -noupdate /uart_loopback_tb/key_in
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_clk_115200
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_clk_57600
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_clk_38400
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_clk_19200
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_clk_9600
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_clk
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/uart_baud
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/txd
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/sys_rst_n
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/sys_clk
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/send_data_flag
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/sel
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/seg
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/rxd
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/rec_flag
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/rec_data
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/key_in
add wave -noupdate -expand -group uart_loopback /uart_loopback_tb/uart_loopback_inst/clk_1khz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {369320194 ps} 0}
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
WaveRestoreZoom {316147920 ps} {578292080 ps}
