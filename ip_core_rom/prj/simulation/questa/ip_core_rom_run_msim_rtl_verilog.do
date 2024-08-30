transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_rom/rtl {D:/git-repository/fpga_training/ip_core_rom/rtl/rom_ip_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_rom/rtl {D:/git-repository/fpga_training/ip_core_rom/rtl/addr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_rom/prj {D:/git-repository/fpga_training/ip_core_rom/prj/ip_core_rom.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_rom/prj/../sim {D:/git-repository/fpga_training/ip_core_rom/prj/../sim/rom_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  rom_tb

add wave *
view structure
view signals
run -all
