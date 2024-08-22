`timescale 1ns/1ps

module digital_clock_v1_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_adjust;
    reg key_add;
    reg key_sub;
    wire [2:0] sel;
    wire [7:0] seg;

    defparam		digital_clock_inst.clk_logic_ctrl_dut.sec_ctrl_dut.T1s = 10;		//5MHZ
	defparam		digital_clock_inst.clk_logic_ctrl_dut.min_flash_dut.T = 10;		    //5MHz
    defparam		digital_clock_inst.clk_logic_ctrl_dut.hour_flash_dut.T = 10;		//5MHz
    defparam		digital_clock_inst.seven_tube_dut.div_clk_dut.CNT_MAX = 50;		    //5MHz
    defparam		digital_clock_inst.key_process_dut.key_filter_adjust.T10ms= 5;	//100ns
    defparam		digital_clock_inst.key_process_dut.key_filter_add.T10ms= 5;		//100ns
    defparam		digital_clock_inst.key_process_dut.key_filter_sub.T10ms= 5;		//100ns

    digital_clock digital_clock_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_adjust (key_adjust),
        .key_add (key_add),
        .key_sub (key_sub),
        .sel (sel),
        .seg (seg),
		.beep (beep)
    );

    initial		sys_clk = 1'b1;
	always #10	sys_clk = ~sys_clk;
	
	initial		begin
		sys_rst_n = 1'b0;
		key_adjust = 1'b1;
        key_add = 1'b1;
        key_sub = 1'b1;
		#200.1
		sys_rst_n = 1'b1;
		
		#2000
		key_adjust = 1'b0;				// Adjust to minute
		#500
		key_adjust = 1'b1;
		#500
        
		#2000
		key_add = 1'b0;				    // Add by 1 minute
		#500
		key_add = 1'b1;
		#500
        
		#2000
		key_sub = 1'b0;				    // Subtract by 1 minute
		#500
		key_sub = 1'b1;
		#500
		
		#2000
		key_adjust = 1'b0;				// Adjust to hour
		#500
		key_adjust = 1'b1;
		#500
        
		#2000
		key_add = 1'b0;				    // Add by 1 second
		#500
		key_add = 1'b1;
		#500
        
		#2000
		key_sub = 1'b0;				    // Subtract by 1 second
		#500
		key_sub = 1'b1;
		#500
		
		#2000
		key_adjust = 1'b0;				// Reset to normal
		#500
		key_adjust = 1'b1;
		#500;
	end
endmodule