`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:26 10/28/2015 
// Design Name: 
// Module Name:    fault_path 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 错误路径约束
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module fault_path (
    // 系统相关信号
    input           rst_n,
    // SPI从机CPOL=0,CPHA=0
    input           cs_n,
    input           scl,
    input           sda,
    
    // 缓存读取数据
    input           rd_clk,
    input           rd_en,
    output  [7:0]   rddata,
    output          empty
);

	/*********************************************************
	SPI数据接收
	*********************************************************/
	reg [7:1] rv_sft_buf; // 移位寄存器
	reg [2:0] cnt;

	always @(posedge scl or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 3'd0;
			rv_sft_buf <= 7'd0;
		end else if (~cs_n) begin
			if (cnt == 7)
				cnt <= 3'd0;
			else 
				cnt <= cnt + 1'b1;
			case (cnt)
				0: rv_sft_buf[7] <= sda;
				1: rv_sft_buf[6] <= sda;
				2: rv_sft_buf[5] <= sda;
				3: rv_sft_buf[4] <= sda;
				4: rv_sft_buf[3] <= sda;
				5: rv_sft_buf[2] <= sda;
				6: rv_sft_buf[1] <= sda;
				default: rv_sft_buf <= rv_sft_buf;
			endcase
		end
	end

	/*********************************************************
	fifo
	*********************************************************/
	wire wr_clk;
	assign wr_clk = scl;
	reg wr_en;

	wire [7:0] wr_data;
	wire full;

	always @(posedge scl or negedge rst_n) begin
		if (~rst_n)
			wr_en <= 1'b0;
		else if ((~cs_n) && (cnt == 3'd6) && (~full))
			wr_en <= 1'b1;
		else
			wr_en <= 1'b0;
	end

	assign wr_data = {rv_sft_buf[7:1], sda};

	fifo fifo_inst (
		.wr_clk(wr_clk),  // input wire wr_clk
		.rd_clk(rd_clk),  // input wire rd_clk
		.din(wr_data),    // input wire [7 : 0] din
		.wr_en(wr_en),    // input wire wr_en
		.rd_en(rd_en),    // input wire rd_en
		.dout(rddata),    // output wire [7 : 0] dout
		.full(full),      // output wire full
		.empty(empty)     // output wire empty
	);

endmodule