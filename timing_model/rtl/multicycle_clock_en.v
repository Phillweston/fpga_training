`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:26 10/28/2015 
// Design Name: 
// Module Name:    multicycle_clock_en 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 多周期约束实例程序
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module multicycle_clock_en (
    input           clk,
    input           rst_n,
    input   [3:0]   din,    
    output  [7:0]   dout
);

	reg en; // 使能信号
	reg [3:0] din_r; // 数据寄存
	reg [7:4] din_r_en; // 使能为1寄存器
	reg [3:0] din_r_nen; // 使能为0寄存器

	reg [7:0] din_r_com; // 合并数据寄存器
	reg [7:0] dout_r; // 使能输出寄存器

	/*********************************************************
	数据寄存
	*********************************************************/
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			din_r <= 'd0;
		else
			din_r <= din;
	end

	/*********************************************************
	二分频的使能信号
	*********************************************************/                
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			en <= 1'b0;
		else 
			en <= ~en;
	end

	/*********************************************************
	在使能信号为1情况下寄存数已经寄存在din_r数据
	*********************************************************/
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			din_r_en <= 'd0;
		else if (en)
			din_r_en <= din_r;
		else
			din_r_en <= din_r_en;
	end

	/*********************************************************
	在使能信号为0情况下寄存数已经寄存在din_r数据
	*********************************************************/
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			din_r_nen <= 'd0;
		else if (~en)
			din_r_nen <= din_r;
		else
			din_r_nen <= din_r_nen;
	end

	/*********************************************************
	在使能信号为0情况下合并寄存器 din_r_en, din_r_nen
	*********************************************************/            
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			din_r_com <= 'd0;
		else if (~en)
			din_r_com <= {din_r_en, din_r_nen};
		else
			din_r_com <= din_r_com;
	end

	/*********************************************************
	在使能信号为0情况下输出合并的数据
	*********************************************************/            
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			dout_r <= 'd0;
		else if (~en)
			dout_r <= din_r_com;
		else
			dout_r <= dout_r;
	end

	assign dout = dout_r;

endmodule