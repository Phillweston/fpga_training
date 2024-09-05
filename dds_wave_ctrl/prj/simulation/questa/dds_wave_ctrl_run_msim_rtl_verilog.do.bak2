transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/wave_select.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/pulse_cnt.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/edge_detection.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/dds_wave_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/rtl {D:/git-repository/fpga_training/dds_wave_ctrl/rtl/addr_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/prj {D:/git-repository/fpga_training/dds_wave_ctrl/prj/rom_sine.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/prj {D:/git-repository/fpga_training/dds_wave_ctrl/prj/rom_sawtooth.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/prj {D:/git-repository/fpga_training/dds_wave_ctrl/prj/rom_square.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/prj {D:/git-repository/fpga_training/dds_wave_ctrl/prj/rom_triangular.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/dds_wave_ctrl/prj/../sim {D:/git-repository/fpga_training/dds_wave_ctrl/prj/../sim/dds_wave_ctrl_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  dds_wave_ctrl_tb

add wave *
view structure
view signals
run -all
