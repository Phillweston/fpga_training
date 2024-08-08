transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/led_top/rtl {D:/git-repository/fpga_training/led_top/rtl/breath_led.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/led_top/rtl {D:/git-repository/fpga_training/led_top/rtl/led_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/led_top/rtl {D:/git-repository/fpga_training/led_top/rtl/flash_led.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/led_top/rtl {D:/git-repository/fpga_training/led_top/rtl/clk_div.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/led_top/prj/../sim {D:/git-repository/fpga_training/led_top/prj/../sim/led_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  led_top_tb

add wave *
view structure
view signals
run -all
