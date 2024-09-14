transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/key_toggle.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/vga_block_catch.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/move_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/block_move.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/rtl {D:/git-repository/fpga_training/vga_block_catch/rtl/beep_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/prj {D:/git-repository/fpga_training/vga_block_catch/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/prj/db {D:/git-repository/fpga_training/vga_block_catch/prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/vga_block_catch/prj/../sim {D:/git-repository/fpga_training/vga_block_catch/prj/../sim/vga_block_catch_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  vga_block_catch_tb

add wave *
view structure
view signals
run -all
