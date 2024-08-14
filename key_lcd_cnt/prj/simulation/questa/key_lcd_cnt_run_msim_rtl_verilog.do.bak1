transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/rtl {D:/git-repository/fpga_training/key_lcd_cnt/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/rtl {D:/git-repository/fpga_training/key_lcd_cnt/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/rtl {D:/git-repository/fpga_training/key_lcd_cnt/rtl/pulse_cnt.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/rtl {D:/git-repository/fpga_training/key_lcd_cnt/rtl/key_lcd_cnt.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/rtl {D:/git-repository/fpga_training/key_lcd_cnt/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/rtl {D:/git-repository/fpga_training/key_lcd_cnt/rtl/clk_div_2khz.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/key_lcd_cnt/prj/../sim {D:/git-repository/fpga_training/key_lcd_cnt/prj/../sim/key_lcd_cnt_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  key_lcd_cnt_tb

add wave *
view structure
view signals
run -all
