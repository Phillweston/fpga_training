transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/seven_tube_drive.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/shift_adjust.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/bin2bcd.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/adjust.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/check_edge.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/key_filter.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/dds.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/key_handle.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/control.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/show.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/wave_generate.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/addr_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/prj/ipcore/rom1024x8 {C:/Users/86150/Desktop/dds_design/prj/ipcore/rom1024x8/rom1024x8.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/src {C:/Users/86150/Desktop/dds_design/src/adjust_a.v}
vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/prj/ipcore/div {C:/Users/86150/Desktop/dds_design/prj/ipcore/div/mydiv.v}

vlog -vlog01compat -work work +incdir+C:/Users/86150/Desktop/dds_design/prj/../sim {C:/Users/86150/Desktop/dds_design/prj/../sim/dds_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  dds_tb

add wave *
view structure
view signals
run -all
