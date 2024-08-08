transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_led/rtl {D:/git-repository/fpga_training/flash_led/rtl/led_driver_fsm.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_led/rtl {D:/git-repository/fpga_training/flash_led/rtl/clk_div_2hz.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/flash_led/prj/../sim {D:/git-repository/fpga_training/flash_led/prj/../sim/led_driver_fsm_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  led_driver_fsm_tb

add wave *
view structure
view signals
run -all
