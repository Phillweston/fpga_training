onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/sys_clk
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/sys_rst_n
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/rd_data
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/empty
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/full
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/wr_req
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/wr_data
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/rd_req
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/almost_empty
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/almost_full
add wave -noupdate -radix unsigned /ip_scfifo_top_tb/scfifo_top_inst/usedw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8262708 ps} 0}
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
WaveRestoreZoom {0 ps} {32768 ns}
