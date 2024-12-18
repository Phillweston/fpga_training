transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/key_flash_state.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/matrix_keyboard.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/seg_flash.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/clk_div_1hz.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/clk_div_1khz.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/edge_detection.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/seg_ctrl_sec.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/seg_ctrl_min.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/seg_ctrl_hour.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/logic_ctrl_v1.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/digital_clock_v1.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/cmp.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/bin2bcd.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/bcd_modify.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/rtl {D:/git-repository/fpga_training/digital_clock/rtl/key_process.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/prj/../sim {D:/git-repository/fpga_training/digital_clock/prj/../sim/digital_clock_v1_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  digital_clock_v1_tb

add wave *
view structure
view signals
run -all
