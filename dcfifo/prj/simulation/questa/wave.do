onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/sys_clk
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/sys_rst_n
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/rd_data
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/wr_clk
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/rd_clk
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/locked
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/rd_empty
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/rd_full
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/rd_req
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/wr_empty
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/wr_full
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/wr_req
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/wr_data
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/wr_usedw
add wave -noupdate /ip_dcfifo_top_tb/dcfifo_top_inst/rd_usedw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23555788 ps} 0}
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
WaveRestoreZoom {0 ps} {65536 ns}
