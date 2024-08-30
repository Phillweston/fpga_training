onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/sys_clk
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/sys_rst_n
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram_ctrl_inst/state
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram1_rd_data
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram2_rd_data
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/clk_50m
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/clk_25m
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/rst_n
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/data_en
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/data_in
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram1_wr_en
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram1_rd_en
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram1_wr_addr
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram1_rd_addr
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram1_wr_data
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram2_wr_en
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram2_rd_en
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram2_wr_addr
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram2_rd_addr
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/ram2_wr_data
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/data_out
add wave -noupdate -radix unsigned /pingpong_tb/pingpong_top_inst/locked
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86768556 ps} 0}
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
WaveRestoreZoom {84435200 ps} {100819200 ps}
