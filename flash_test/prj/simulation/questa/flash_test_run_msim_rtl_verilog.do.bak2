transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/rtl {D:/git-repository/fpga_training/flash_test/rtl/spi_tx.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/rtl {D:/git-repository/fpga_training/flash_test/rtl/spi_rx.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/rtl {D:/git-repository/fpga_training/flash_test/rtl/spi_8bit_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/rtl {D:/git-repository/fpga_training/flash_test/rtl/flash_test.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/rtl {D:/git-repository/fpga_training/flash_test/rtl/flash_ctrl.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/testbench.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/parameter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/memory_access.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/m25p16_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/M25p16.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/internal_logic.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12 {D:/git-repository/fpga_training/flash_test/prj/../m25p16-vg-v12/acdc_check.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_test/prj/../sim {D:/git-repository/fpga_training/flash_test/prj/../sim/flash_test_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  flash_test_tb

add wave *
view structure
view signals
run -all
