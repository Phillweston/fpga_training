transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {digital_clock.vo}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/digital_clock/prj/../sim {D:/git-repository/fpga_training/digital_clock/prj/../sim/digital_clock_v1_tb.v}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  digital_clock_v1_tb

add wave *
view structure
view signals
run -all
