transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds/rtl {D:/git-repository/fpga_training/dds/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds/rtl {D:/git-repository/fpga_training/dds/rtl/dds.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds/rtl {D:/git-repository/fpga_training/dds/rtl/addr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds/prj {D:/git-repository/fpga_training/dds/prj/ip_1port_rom.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds/prj/../sim {D:/git-repository/fpga_training/dds/prj/../sim/dds_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  dds_tb

add wave *
view structure
view signals
run -all
