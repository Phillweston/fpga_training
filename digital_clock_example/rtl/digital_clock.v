module digital_clock(
	input							sys_clk,
	input							sys_rst_n,
	input							key_adjust,
	input							key_add,
	input							key_sub,
	
	output			[2:0]			sel,
	output			[7:0]			seg,
	output							beep
);

	wire							key_adjust_flag;
	wire							key_add_flag;
	wire							key_sub_flag;
	
	wire				[23:0]		show_data;

	key_process key_process_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.key_adjust					(key_adjust),
		.key_add					(key_add),
		.key_sub					(key_sub),
		
		.key_adjust_flag			(key_adjust_flag),
		.key_add_flag				(key_add_flag),
		.key_sub_flag				(key_sub_flag)
	);
	
	clk_logic_ctrl clk_logic_ctrl_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.key_adjust_flag			(key_adjust_flag),
		.key_add_flag				(key_add_flag),
		.key_sub_flag				(key_sub_flag),
		
		.show_data					(show_data)
	);
	
	seven_tube seven_tube_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n					(sys_rst_n),
		.data_in					(show_data),
		
		.sel						(sel),
		.seg						(seg)
	);

	beep_driver beep_driver_add(
        .sys_clk					(sys_clk),
        .sys_rst_n					(sys_rst_n),
        .key_flag					(key_add),
        .beep						(beep)
    );

    beep_driver beep_driver_sub(
        .sys_clk					(sys_clk),
        .sys_rst_n					(sys_rst_n),
        .key_flag					(key_sub),
        .beep						(beep)
    );
	
endmodule