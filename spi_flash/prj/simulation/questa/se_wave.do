onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spi_flash_se_tb/sys_clk
add wave -noupdate /spi_flash_se_tb/sys_rst_n
add wave -noupdate /spi_flash_se_tb/spi_cs_n
add wave -noupdate /spi_flash_se_tb/spi_sck
add wave -noupdate /spi_flash_se_tb/spi_mosi
add wave -noupdate /spi_flash_se_tb/spi_miso
add wave -noupdate /spi_flash_se_tb/check_wip
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1545470 ps} 0}
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
WaveRestoreZoom {0 ps} {16384 ns}
