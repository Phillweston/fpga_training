transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/check_characters/rtl {D:/git-repository/fpga_training/check_characters/rtl/check_characters.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/check_characters/prj/../sim {D:/git-repository/fpga_training/check_characters/prj/../sim/check_characters_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  check_characters_tb

add wave *
view structure
view signals
run -all