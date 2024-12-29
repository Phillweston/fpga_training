`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:26 10/28/2015 
// Design Name: 
// Module Name:    clock_constraints 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 周期约束实例
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module clock_constraints (
    input clk,
    output rst_n,
    
    // 输出系统时钟
    output clk_50mhz,
    
    // 输出选择时钟
    input en_clk,
    output clk_o
    // output clk_1mhz_20mhz
	);

	wire clk_1mhz;

	pll pll_inst (
		// Clock out ports
		.clk_out1(clk_50mhz),     // output clk_out1
		.clk_out2(clk_1mhz),      // output clk_out2  6.5mhz
		// Status and control signals
		.locked(rst_n),           // output locked
		// Clock in ports
		.clk_in1(clk)             // input clk_in1
	);

	reg clk_0p25mhz;
	reg cnt;

	always @(posedge clk_1mhz or negedge rst_n) begin
		if (~rst_n)
			cnt <= 0;
		else  
			cnt <= ~cnt;
	end

	always @(posedge clk_1mhz or negedge rst_n) begin
		if (~rst_n)
			clk_0p25mhz <= 1'b0;
		else if (cnt == 1)
			clk_0p25mhz <= ~clk_0p25mhz;
	end

	// 产生选择时钟
	reg clk_0p5mhz;

	always @(posedge clk_1mhz or negedge rst_n) begin
		if (~rst_n)
			clk_0p5mhz <= 1'b0;
		else
			clk_0p5mhz <= ~clk_0p5mhz;
	end

	// 门控时钟
	assign clk_o = en_clk ? clk_0p25mhz : clk_0p5mhz;

endmodule