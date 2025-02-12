transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/ETH/rtl/rtl0 {C:/Users/86150/Desktop/ETH/rtl/rtl0/crc_gen.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/ETH/prj/prj1/../../rtl/rtl0 {C:/Users/86150/Desktop/ETH/prj/prj1/../../rtl/rtl0/crc_gen_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  crc_gen_tb

add wave *
view structure
view signals
run -all
