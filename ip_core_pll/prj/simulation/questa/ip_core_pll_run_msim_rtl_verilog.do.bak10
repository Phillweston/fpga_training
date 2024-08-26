transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/rtl {D:/git-repository/fpga_training/ip_core_pll/rtl/top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/rtl {D:/git-repository/fpga_training/ip_core_pll/rtl/led_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/rtl {D:/git-repository/fpga_training/ip_core_pll/rtl/flash_led.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/rtl {D:/git-repository/fpga_training/ip_core_pll/rtl/clk_div.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/prj {D:/git-repository/fpga_training/ip_core_pll/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/prj/db {D:/git-repository/fpga_training/ip_core_pll/prj/db/clk_gen_altpll1.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_pll/prj/../sim {D:/git-repository/fpga_training/ip_core_pll/prj/../sim/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
