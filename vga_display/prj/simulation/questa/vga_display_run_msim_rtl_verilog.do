transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/rtl {D:/git-repository/fpga_training/vga_display/rtl/pulse_cnt.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/rtl {D:/git-repository/fpga_training/vga_display/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/rtl {D:/git-repository/fpga_training/vga_display/rtl/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/rtl {D:/git-repository/fpga_training/vga_display/rtl/vga_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/prj {D:/git-repository/fpga_training/vga_display/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/prj/db {D:/git-repository/fpga_training/vga_display/prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_display/prj/../sim {D:/git-repository/fpga_training/vga_display/prj/../sim/vga_driver_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  vga_driver_tb

add wave *
view structure
view signals
run -all
