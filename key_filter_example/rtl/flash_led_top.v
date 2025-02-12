module flash_led_top(
	input						sys_clk,
	input						sys_rst_n,
	
	output		[3:0]		LED
);

	flash_led flash_led_dut1(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED[0])
	);
	
	flash_led flash_led_dut2(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED[1])
	);
	
	flash_led flash_led_dut3(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED[2])
	);
	
	flash_led flash_led_dut4(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED[3])
	);

endmodule
