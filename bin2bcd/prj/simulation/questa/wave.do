onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bin
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data0
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data1
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data2
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data3
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data4
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data5
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data6
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data7
add wave -noupdate -radix binary /bin2bcd_v2_tb/bin2bcd_v2_inst/bcd_data8
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {330811 ps} 0}
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
WaveRestoreZoom {0 ps} {4096 ns}
