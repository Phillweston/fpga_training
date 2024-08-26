transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/shift_data.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/keyboard_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/edge_check.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/beep_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/rtl {D:/git-repository/fpga_training/keyboard_scan/rtl/keyboard_scan.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/keyboard_scan/prj/../sim {D:/git-repository/fpga_training/keyboard_scan/prj/../sim/keyboard_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  keyboard_top_tb

add wave *
view structure
view signals
run -all
