transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/rtl {D:/git-repository/fpga_training/uart_tx/rtl/uart_tx_v1.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/rtl {D:/git-repository/fpga_training/uart_tx/rtl/uart_transmitter.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/rtl {D:/git-repository/fpga_training/uart_tx/rtl/keyboard_scan.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/rtl {D:/git-repository/fpga_training/uart_tx/rtl/div_clk.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/prj {D:/git-repository/fpga_training/uart_tx/prj/clk_gen.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/prj {D:/git-repository/fpga_training/uart_tx/prj/tx_fifo.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/prj/db {D:/git-repository/fpga_training/uart_tx/prj/db/clk_gen_altpll.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/uart_tx/prj/../sim {D:/git-repository/fpga_training/uart_tx/prj/../sim/uart_transmitter_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_transmitter_tb

add wave *
view structure
view signals
run -all
