transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/clk_div/rtl {D:/git-repository/fpga_training/clk_div/rtl/clk_div_10.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/clk_div/prj/../sim {D:/git-repository/fpga_training/clk_div/prj/../sim/clk_div_10_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  clk_div_10_tb

add wave *
view structure
view signals
run -all