transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/seven_tube/rtl {D:/git-repository/fpga_training/seven_tube/rtl/shift_data.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/seven_tube/rtl {D:/git-repository/fpga_training/seven_tube/rtl/seven_tube_shift.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/seven_tube/rtl {D:/git-repository/fpga_training/seven_tube/rtl/seg_ctrl_shift.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/seven_tube/rtl {D:/git-repository/fpga_training/seven_tube/rtl/clk_div_2khz.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/seven_tube/prj/../sim {D:/git-repository/fpga_training/seven_tube/prj/../sim/seven_tube_shift_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  seven_tube_shift_tb

add wave *
view structure
view signals
run -all
