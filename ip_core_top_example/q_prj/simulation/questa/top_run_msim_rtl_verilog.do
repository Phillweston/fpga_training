transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/keyboard_scan.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/edge_check.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/beep_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/dpram_wr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/dpram_rd_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/q_prj {D:/git-repository/fpga_training/ip_core_top_example/q_prj/dpram_ip.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/q_prj {D:/git-repository/fpga_training/ip_core_top_example/q_prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/dcfifo_div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/dcfifo_wr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/rtl {D:/git-repository/fpga_training/ip_core_top_example/rtl/dcfifo_rd_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/q_prj {D:/git-repository/fpga_training/ip_core_top_example/q_prj/dcfifo_ip.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/q_prj/db {D:/git-repository/fpga_training/ip_core_top_example/q_prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_top_example/q_prj/../sim {D:/git-repository/fpga_training/ip_core_top_example/q_prj/../sim/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
