transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/key_toggle.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/key_led_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/flow_led.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/flash_led.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/clk_div.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/rtl {D:/git-repository/fpga_training/key_led/rtl/breath_led.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_led/prj/../sim {D:/git-repository/fpga_training/key_led/prj/../sim/key_led_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  key_led_tb

add wave *
view structure
view signals
run -all
