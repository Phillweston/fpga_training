transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/sec_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/min_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/key_process.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/hour_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/edge_check.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/cmp.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/bin2bcd.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/bcd_modify.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/digital_clock.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/clk_logic_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/logic_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/min_flash.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/rtl/hour_flash.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/q_prj/../sim {C:/Users/86150/Desktop/fpga_0729/digital_clock_v1/q_prj/../sim/digital_clock_v1_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  digital_clock_v1_tb

add wave *
view structure
view signals
run -all
