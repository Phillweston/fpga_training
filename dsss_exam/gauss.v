`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:Engi-kou
//
// Create Date:   14:34:34 09/26/2015
// Design Name:/gauss.v
// Module Name:   
// Project Name: 
// Target Device:
// Tool versions:
// Description:均匀分布的随机数的转化为高斯分布的随机数
//
// Verilog Test Fixture created by ISE for module: seq_top
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
`define sigma 1
module gauss
(
	input clk,
	input rst_n,
	input [27:0] m_array1,
	input [27:0] m_array2,
	input [27:0] m_array3,
	input [27:0] m_array4,
	input [27:0] m_array5,
	input [27:0] m_array6,
	input [27:0] m_array7,
	input [27:0] m_array8,
	input [27:0] m_array9,
	input [27:0] m_arraya,
	input [27:0] m_arrayb,
	input [27:0] m_arrayc,
	output reg signed [31:0] awgn_out,
	output reg signed [31:0] awgn_out_quantization,
	output reg signed [31:0] awgn_out_k
);

	wire signed [31:0] awgn_out_temp;
	wire signed [6:0] awgn_out_k_temp;
	//噪声系数
	real sigma_0dB = 0.125;		real sigma_5dB = 0.0703;
	real sigma_1dB = 0.1114;	real sigma_6dB = 0.0626;
	real sigma_2dB = 0.0993;	real sigma_7dB = 0.0558;
	real sigma_3dB = 0.0885;	real sigma_8dB = 0.0498;
	real sigma_4dB = 0.0789;	real sigma_9dB = 0.0444;
	real sigma_10dB = 0.0395;
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			awgn_out <= 'd0;
		else
			awgn_out <=	m_array1 + m_array2 + m_array3 + m_array4 +
						m_array5 + m_array6 + m_array7 + m_array8 +
						m_array9 + m_arraya + m_arrayb + m_arrayc
						- 32'd1610612730;//{(2^28-1)/2}*12
	end

	assign awgn_out_temp = awgn_out;
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			awgn_out_quantization <= 'd0;
		else
			awgn_out_quantization <= awgn_out_temp[31:25];
	end

	assign awgn_out_k_temp = awgn_out_quantization;
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			awgn_out_k <= 'd0;
		else case(`sigma)
			0: awgn_out_k <= awgn_out_k_temp * sigma_0dB;
			1: awgn_out_k <= awgn_out_k_temp * sigma_1dB;
			2: awgn_out_k <= awgn_out_k_temp * sigma_2dB;
			3: awgn_out_k <= awgn_out_k_temp * sigma_3dB;
			4: awgn_out_k <= awgn_out_k_temp * sigma_4dB;
			5: awgn_out_k <= awgn_out_k_temp * sigma_5dB;
			6: awgn_out_k <= awgn_out_k_temp * sigma_6dB;
			7: awgn_out_k <= awgn_out_k_temp * sigma_7dB;
			8: awgn_out_k <= awgn_out_k_temp * sigma_8dB;
			9: awgn_out_k <= awgn_out_k_temp * sigma_9dB;
			10: awgn_out_k <= awgn_out_k_temp * sigma_10dB;
			default:; 
		endcase
	end
endmodule