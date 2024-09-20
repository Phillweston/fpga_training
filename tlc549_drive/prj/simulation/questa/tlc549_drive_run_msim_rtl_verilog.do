transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/tlc549_drive/rtl {D:/git-repository/fpga_training/tlc549_drive/rtl/tlc549_drive.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/tlc549_drive/prj/../sim {D:/git-repository/fpga_training/tlc549_drive/prj/../sim/tlc549_drive_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tlc549_drive_tb

add wave *
view structure
view signals
run -all
