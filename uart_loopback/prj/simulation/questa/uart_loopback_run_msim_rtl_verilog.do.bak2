transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/uart_tx.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/uart_rx.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/uart_loopback.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/uart_clk_div.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/pulse_cnt.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/rtl {D:/git-repository/fpga_training/uart_loopback/rtl/baud_select.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_loopback/prj/../sim {D:/git-repository/fpga_training/uart_loopback/prj/../sim/uart_loopback_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_loopback_tb

add wave *
view structure
view signals
run -all
