transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_spram/prj {D:/git-repository/fpga_training/ip_core_spram/prj/ip_core_spram.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/ip_core_spram/prj/../sim {D:/git-repository/fpga_training/ip_core_spram/prj/../sim/spram_v1_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  spram_v1_tb

add wave *
view structure
view signals
run -all
