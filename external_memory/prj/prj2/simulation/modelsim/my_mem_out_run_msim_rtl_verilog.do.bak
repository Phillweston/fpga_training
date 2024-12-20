transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_sdram.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_param.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_ctl.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_write.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_ref.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_read.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/rtl {C:/Users/86150/Desktop/mem_out_exanm/rtl/sdr_init.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/prj/prj2/../../rtl/sim {C:/Users/86150/Desktop/mem_out_exanm/prj/prj2/../../rtl/sim/mt48lc32m16a2.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/mem_out_exanm/prj/prj2/../../rtl/sim {C:/Users/86150/Desktop/mem_out_exanm/prj/prj2/../../rtl/sim/tesebench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tesebench

add wave *
view structure
view signals
run -all
