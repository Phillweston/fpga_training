transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/rtl {D:/git-repository/fpga_training/ip_core_dpram/rtl/dpram_wr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/rtl {D:/git-repository/fpga_training/ip_core_dpram/rtl/dpram_v3_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/rtl {D:/git-repository/fpga_training/ip_core_dpram/rtl/dpram_rd_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/prj {D:/git-repository/fpga_training/ip_core_dpram/prj/ip_core_dpram_v2.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/prj {D:/git-repository/fpga_training/ip_core_dpram/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/prj/db {D:/git-repository/fpga_training/ip_core_dpram/prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_dpram/prj/../sim {D:/git-repository/fpga_training/ip_core_dpram/prj/../sim/dpram_v3_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  dpram_v3_tb

add wave *
view structure
view signals
run -all
