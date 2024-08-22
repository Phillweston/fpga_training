`timescale 1ns/1ps
module top_tb;

	reg						sys_clk;
	reg						sys_rst_n;
	reg						key_in;
	
	wire			[3:0]		LED;
	wire			[2:0]		sel;
	wire			[7:0]		seg;
	
	defparam		top_inst.key_filter_dut.T10ms = 10;
	defparam		top_inst.led_driver_dut.CNT_MAX = 10;
	defparam		top_inst.flash_led_dut.flash_led_dut1.CNT_MAX = 5;
	defparam		top_inst.flash_led_dut.flash_led_dut2.CNT_MAX = 5;
	defparam		top_inst.flash_led_dut.flash_led_dut3.CNT_MAX = 5;
	defparam		top_inst.flash_led_dut.flash_led_dut4.CNT_MAX = 5;
	
	defparam		top_inst.breathe_led_dut.breathe_led_dut1.T100 = 5;
	defparam		top_inst.breathe_led_dut.breathe_led_dut1.T2us = 50;
	defparam		top_inst.breathe_led_dut.breathe_led_dut1.T2ms = 50;
	
	defparam		top_inst.breathe_led_dut.breathe_led_dut2.T100 = 5;
	defparam		top_inst.breathe_led_dut.breathe_led_dut2.T2us = 50;
	defparam		top_inst.breathe_led_dut.breathe_led_dut2.T2ms = 50;
	
	defparam		top_inst.breathe_led_dut.breathe_led_dut3.T100 = 5;
	defparam		top_inst.breathe_led_dut.breathe_led_dut3.T2us = 50;
	defparam		top_inst.breathe_led_dut.breathe_led_dut3.T2ms = 50;
	
	defparam		top_inst.breathe_led_dut.breathe_led_dut4.T100 = 5;
	defparam		top_inst.breathe_led_dut.breathe_led_dut4.T2us = 50;
	defparam		top_inst.breathe_led_dut.breathe_led_dut4.T2ms = 50;

	top top_inst(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		.key_in				(key_in),
		
		.LED					(LED),
		.sel					(sel),
		.seg					(seg)
	);
	
	initial		sys_clk = 1'b1;
	always #10	sys_clk = ~sys_clk;
	
	initial	begin
		sys_rst_n = 1'b0;
		key_in = 1'b1;					//初始时按键处于抬起状态
		
		#200.1
		sys_rst_n = 1'b1;
		
		//模拟独立按键的动作
		key_in = 1'b0;
		#350
		key_in = 1'b1;
		#460
		
		//模拟独立按键的动作
		key_in = 1'b0;
		#350
		key_in = 1'b1;
		#460
		
		//模拟独立按键的动作
		key_in = 1'b0;
		#350
		key_in = 1'b1;
		#460
		
		//模拟独立按键的动作
		key_in = 1'b0;
		#350
		key_in = 1'b1;
		#460
		
		//模拟独立按键的动作
		key_in = 1'b0;
		#350
		key_in = 1'b1;
		#460
		$stop;
	end

endmodule
