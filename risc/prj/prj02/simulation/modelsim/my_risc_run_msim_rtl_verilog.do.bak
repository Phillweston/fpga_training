transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/ui.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/risc.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/pc_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/ir_regester.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/bus_ctl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/rtl {C:/Users/86150/Desktop/risc_exam/rtl/acc.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/risc_exam/prj/prj02/../../rtl {C:/Users/86150/Desktop/risc_exam/prj/prj02/../../rtl/risc_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  risc_tb

add wave *
view structure
view signals
run -all
