transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/keyboard_scan.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/edge_check.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/calculator_top.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/beep_driver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/rtl {D:/git-repository/fpga_training/calculator/rtl/alu.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/calculator/prj/../sim {D:/git-repository/fpga_training/calculator/prj/../sim/calculator_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  calculator_top_tb

add wave *
view structure
view signals
run -all
