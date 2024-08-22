transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/led_driver.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/flash_led.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/breathe_led.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/mux_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/flash_led_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl {C:/Users/86150/Desktop/fpga_0729/key_filter_top/rtl/breathe_led_top.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/key_filter_top/q_prj/../sim {C:/Users/86150/Desktop/fpga_0729/key_filter_top/q_prj/../sim/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
