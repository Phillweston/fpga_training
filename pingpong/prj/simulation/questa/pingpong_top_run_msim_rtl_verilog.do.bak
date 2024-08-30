transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/rtl {D:/git-repository/fpga_training/pingpong/rtl/ram_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/rtl {D:/git-repository/fpga_training/pingpong/rtl/pingpong_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/rtl {D:/git-repository/fpga_training/pingpong/rtl/data_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/prj {D:/git-repository/fpga_training/pingpong/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/prj {D:/git-repository/fpga_training/pingpong/prj/dp_ram_1.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/prj {D:/git-repository/fpga_training/pingpong/prj/dp_ram_2.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/prj/db {D:/git-repository/fpga_training/pingpong/prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/pingpong/prj/../sim {D:/git-repository/fpga_training/pingpong/prj/../sim/pingpong_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  pingpong_tb

add wave *
view structure
view signals
run -all
