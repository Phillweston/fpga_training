transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/rtl {D:/git-repository/fpga_training/dcfifo/rtl/dcfifo_wr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/rtl {D:/git-repository/fpga_training/dcfifo/rtl/dcfifo_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/rtl {D:/git-repository/fpga_training/dcfifo/rtl/dcfifo_rd_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/prj {D:/git-repository/fpga_training/dcfifo/prj/dcfifo_ip.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/prj {D:/git-repository/fpga_training/dcfifo/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/prj/db {D:/git-repository/fpga_training/dcfifo/prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dcfifo/prj/../sim {D:/git-repository/fpga_training/dcfifo/prj/../sim/ip_dcfifo_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  ip_dcfifo_top_tb

add wave *
view structure
view signals
run -all
