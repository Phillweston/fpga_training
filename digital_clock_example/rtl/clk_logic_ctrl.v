module clk_logic_ctrl(
	input							sys_clk,
	input							sys_rst_n,
	input							key_adjust_flag,
	input							key_add_flag,
	input							key_sub_flag,
	
	output			[23:0]			show_data
);

	//logic_ctrl
	wire							min_en;
	wire							hour_en;
	wire							min_add_flag;
	wire							min_sub_flag;
	wire							hour_add_flag;
	wire							hour_sub_flag;
	
	//sec_ctrl
	wire				[7:0]		sec;
	wire							min_flag;
	
	//min_ctrl
	wire				[7:0]		min;
	wire							hour_flag;
	
	//hour_ctrl
	wire				[7:0]		hour;
	
	//bin2bcd
	wire				[11:0]		bcd_sec;
	wire				[11:0]		bcd_min;
	wire				[11:0]		bcd_hour;
	
	//min_flash
	wire				[7:0]		min_data;
	
	//hour_flash
	wire				[7:0]		hour_data;

	logic_ctrl logic_ctrl_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.key_adjust_flag			(key_adjust_flag),
		.key_add_flag				(key_add_flag),
		.key_sub_flag				(key_sub_flag),
		
		.min_en						(min_en),
		.hour_en					(hour_en),
		.min_add_flag				(min_add_flag),
		.min_sub_flag				(min_sub_flag),
		.hour_add_flag				(hour_add_flag),
		.hour_sub_flag				(hour_sub_flag)
	);
	
	sec_ctrl sec_ctrl_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),					
		
		.sec						(sec),
		.min_flag					(min_flag)
	);
	
	min_ctrl min_ctrl_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.min_flag					(min_flag),
		.min_add_flag				(min_add_flag),
		.min_sub_flag				(min_sub_flag),
		
		.min						(min),
		.hour_flag					(hour_flag)
	);
	
	hour_ctrl hour_ctrl_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.hour_flag					(hour_flag),
		.hour_add_flag				(hour_add_flag),
		.hour_sub_flag				(hour_sub_flag),
		
		.hour						(hour)
	);
	
	bin2bcd bin2bcd_sec(
		.bin						(sec),
		
		.bcd						(bcd_sec)
	);
	
	bin2bcd bin2bcd_min(
		.bin						(min),
		
		.bcd						(bcd_min)
	);

	bin2bcd bin2bcd_hour(
		.bin						(hour),
		
		.bcd						(bcd_hour)
	);

	min_flash min_flash_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.min_en						(min_en),
		.bcd_min					(bcd_min[7:0]),
		
		.min_data					(min_data)
	);
	
	hour_flash hour_flash_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.hour_en					(hour_en),
		.bcd_hour					(bcd_hour[7:0]),
		
		.hour_data					(hour_data)
	);
	
	assign	show_data = {hour_data, min_data, bcd_sec[7:0]};

endmodule
