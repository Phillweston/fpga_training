transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/scfifo/rtl {D:/git-repository/fpga_training/scfifo/rtl/scfifo_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/scfifo/rtl {D:/git-repository/fpga_training/scfifo/rtl/scfifo_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/scfifo/prj {D:/git-repository/fpga_training/scfifo/prj/ip_scfifo.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/scfifo/prj/../sim {D:/git-repository/fpga_training/scfifo/prj/../sim/ip_scfifo_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  ip_scfifo_top_tb

add wave *
view structure
view signals
run -all
