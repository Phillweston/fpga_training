module top(
	input						sys_clk,
	input						sys_rst_n,
	input						key_in,
	
	output		[3:0]		LED,
	output		[2:0]		sel,
	output		[7:0]		seg
);

	wire						key_flag;
	wire			[3:0]		LED1;
	wire			[3:0]		LED2;
	wire			[3:0]		LED3;
	
	wire			[3:0]		cnt_data;

	key_filter key_filter_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		.key_in				(key_in),											
		
		.flag					(key_flag)								
	);
	
	led_driver led_driver_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED1)
	);
	
	breathe_led_top breathe_led_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED2)
	);
	
	flash_led_top flash_led_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.LED					(LED3)
	);

	mux_ctrl mux_ctrl_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		.key_flag			(key_flag),					
		.LED1					(LED1),
		.LED2					(LED2),
		.LED3					(LED3),
		
		.LED					(LED),
		.cnt_time			(cnt_data)
	);
	
	seven_tube seven_tube_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		.data_in				({20'hfffff, cnt_data}),
		
		.sel					(sel),
		.seg					(seg)
	);

endmodule
