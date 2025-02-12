transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/rtl {D:/git-repository/fpga_training/spi_flash/rtl/spi_flash_wren.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/rtl {D:/git-repository/fpga_training/spi_flash/rtl/spi_flash_se.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../sim {D:/git-repository/fpga_training/spi_flash/prj/../sim/spi_flash_se_tb.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/acdc_check.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/internal_logic.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/M25p16.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/m25p16_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/memory_access.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/parameter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/spi_flash/prj/../m25p16-vg-v12/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  spi_flash_se_tb

add wave *
view structure
view signals
run -all
