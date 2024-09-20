transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/tlc5620_drive/rtl {D:/git-repository/fpga_training/tlc5620_drive/rtl/tlc5620_drive_issp.v}
vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/tlc5620_drive/rtl {D:/git-repository/fpga_training/tlc5620_drive/rtl/tlc5620_drive.v}
vlib my_issp
vmap my_issp my_issp
vlog -vlog01compat -work my_issp +incdir+d:/git-repository/fpga_training/tlc5620_drive/prj/db/ip/my_issp {d:/git-repository/fpga_training/tlc5620_drive/prj/db/ip/my_issp/my_issp.v}
vlog -vlog01compat -work my_issp +incdir+d:/git-repository/fpga_training/tlc5620_drive/prj/db/ip/my_issp/submodules {d:/git-repository/fpga_training/tlc5620_drive/prj/db/ip/my_issp/submodules/altsource_probe_top.v}

vlog -vlog01compat -work work +incdir+D:/git-repository/fpga_training/tlc5620_drive/prj/../sim {D:/git-repository/fpga_training/tlc5620_drive/prj/../sim/tlc5620_drive_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L my_issp -voptargs="+acc"  tlc5620_drive_tb

add wave *
view structure
view signals
run -all
