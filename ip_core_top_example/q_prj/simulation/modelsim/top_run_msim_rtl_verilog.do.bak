transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj {C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/keyboard_scan.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/edge_check.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/beep_driver.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/dpram_wr_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/dpram_rd_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj {C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/dpram_ip.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/dcfifo_div_clk.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/dcfifo_wr_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl {C:/Users/86150/Desktop/fpga_0729/ip_core/top/rtl/dcfifo_rd_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj {C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/dcfifo_ip.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/db {C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/../sim {C:/Users/86150/Desktop/fpga_0729/ip_core/top/q_prj/../sim/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
