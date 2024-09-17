transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ip {D:/class170715/video20171022/camera_ov7670_sobel/ip/ram2.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sobel {D:/class170715/video20171022/camera_ov7670_sobel/sobel/sobel_head.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sobel {D:/class170715/video20171022/camera_ov7670_sobel/sobel/sobel_filter_zx1702.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sobel {D:/class170715/video20171022/camera_ov7670_sobel/sobel/fsm.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sobel {D:/class170715/video20171022/camera_ov7670_sobel/sobel/computer.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ov7670 {D:/class170715/video20171022/camera_ov7670_sobel/ov7670/rgb565_data.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ov7670 {D:/class170715/video20171022/camera_ov7670_sobel/ov7670/ov7670.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ov7670 {D:/class170715/video20171022/camera_ov7670_sobel/ov7670/frep_deay.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ov7670 {D:/class170715/video20171022/camera_ov7670_sobel/ov7670/config_reg.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ov7670 {D:/class170715/video20171022/camera_ov7670_sobel/ov7670/cmos_ov7670_config_rgb565_regsiter_data.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/camera_head.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ip {D:/class170715/video20171022/camera_ov7670_sobel/ip/wr_fifo.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/ip {D:/class170715/video20171022/camera_ov7670_sobel/ip/rd_fifo.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel {D:/class170715/video20171022/camera_ov7670_sobel/pll.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel {D:/class170715/video20171022/camera_ov7670_sobel/camera.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/vga_src {D:/class170715/video20171022/camera_ov7670_sobel/vga_src/vga565_sobel.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/db {D:/class170715/video20171022/camera_ov7670_sobel/db/pll_altpll.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sobel {D:/class170715/video20171022/camera_ov7670_sobel/sobel/addr_gen.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/write.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/timer.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/sdram_fsm.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/sdram_controller.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/sdram_control.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/refresh.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/read.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/mux_bus.v}
vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller {D:/class170715/video20171022/camera_ov7670_sobel/sdram_controller/init.v}

vlog -vlog01compat -work work +incdir+D:/class170715/video20171022/camera_ov7670_sobel/vga_src {D:/class170715/video20171022/camera_ov7670_sobel/vga_src/vga565_sobel_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc" vga565_sobel_tb

add wave *
view structure
view signals
run -all
