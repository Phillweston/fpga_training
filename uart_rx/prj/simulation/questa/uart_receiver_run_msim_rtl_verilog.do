transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/uart_clk_div.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/pulse_cnt.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/baud_select.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/seven_tube.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/seg_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/fifo_div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/clk_div_2khz.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/uart_rx.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/rtl {D:/git-repository/fpga_training/uart_rx/rtl/uart_receiver.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/prj {D:/git-repository/fpga_training/uart_rx/prj/rx_fifo.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_rx/prj/../sim {D:/git-repository/fpga_training/uart_rx/prj/../sim/uart_receiver_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_receiver_tb

add wave *
view structure
view signals
run -all
