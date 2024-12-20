`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 10:16:43
// Design Name: 
// Module Name: risc_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module risc_tb;

	localparam
		// 助记符    操作码    描述
		NOP     = 3'b000,    // 空操作
		LDA     = 3'b001,    // 从操作地址所指向的空间的数读出保存累加器中
		STO     = 3'b010,    // 把累加器数写入操作地址所指向的空间
		ADD     = 3'b011,    // 从操作地址所指向的空间的数读出与累加器数相加，结果保存累加器
		NXOR    = 3'b100,    // 从操作地址所指向的空间的数读出与累加器数相异或，结果保存累加器
		SFT     = 3'b101,    // 从操作地址所指向的空间的数读出,循环左移移位，结果保存累加器
		SKP     = 3'b110,    // 跳过下一条指令，执行下下一条指令
		NJMP    = 3'b111;    // 无条件跳转到操作地址所指向的空间

	reg clk;                // RISC核心工作时钟
	reg rst_n;              // RISC复位，低电平有效

	initial begin
		clk = 0;
		rst_n = 0;
		#53 rst_n = 1;
	end

	always #2 clk = ~clk;

	// CPU总线
	// 数据总线
	wire [7:0] bus_data;    // CPU数据总线
	// 地址总线
	wire [12:0] bus_addr;   // CPU地址总线
	// 控制总线
	wire wr;                // CPU控制总线写有效信号
	wire rd;                // CPU控制总线读有效信号

	reg [7:0] bus_data_r;
	reg bus_data_link;

	assign bus_data = bus_data_link ? bus_data_r : 8'hzz;

	always @(posedge clk) begin
		if (rd) begin
			case (bus_addr)
				// LDA 0x1000
				13'h0: begin bus_data_link <= 1'b1; bus_data_r <= {LDA, 5'h10}; end
				13'h1: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h0}; end
				// ADD 0x1001
				13'h2: begin bus_data_link <= 1'b1; bus_data_r <= {ADD, 5'h10}; end
				13'h3: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h1}; end
				// NXOR 0x1002
				13'h4: begin bus_data_link <= 1'b1; bus_data_r <= {NXOR, 5'h10}; end
				13'h5: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h2}; end
				// SFT 0x1003
				13'h6: begin bus_data_link <= 1'b1; bus_data_r <= {SFT, 5'h10}; end
				13'h7: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h3}; end
				// STO 0x1004
				13'h8: begin bus_data_link <= 1'b1; bus_data_r <= {STO, 5'h10}; end
				13'h9: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h4}; end
				// SKP 0xxxxx
				13'hA: begin bus_data_link <= 1'b1; bus_data_r <= {SKP, 5'h10}; end
				13'hB: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h4}; end
				// NOP 0xXXXX
				13'hC: begin bus_data_link <= 1'b1; bus_data_r <= {NOP, 5'hXX}; end
				13'hD: begin bus_data_link <= 1'b1; bus_data_r <= {4'hX, 4'hX}; end
				// NJMP 0x0000
				13'hE: begin bus_data_link <= 1'b1; bus_data_r <= {NJMP, 5'h00}; end
				13'hF: begin bus_data_link <= 1'b1; bus_data_r <= {4'h0, 4'h0}; end
				13'h1000: begin bus_data_link <= 1'b1; bus_data_r <= 8'ha5; end
				13'h1001: begin bus_data_link <= 1'b1; bus_data_r <= 8'h33; end
				13'h1002: begin bus_data_link <= 1'b1; bus_data_r <= 8'h13; end
				13'h1003: begin bus_data_link <= 1'b1; bus_data_r <= 8'h01; end
				default: bus_data_link <= 1'b0;
			endcase
		end else begin
			bus_data_link <= 1'b0;
		end
	end

	risc risc_ins (
		.clk(clk),          // RISC核心工作时钟
		.rst_n(rst_n),      // RISC复位，低电平有效
		// CPU总线
		// 数据总线
		.bus_data(bus_data),    // CPU数据总线
		// 地址总线
		.bus_addr(bus_addr),    // CPU地址总线
		// 控制总线
		.wr(wr),                // CPU控制总线写有效信号
		.rd(rd)                 // CPU控制总线读有效信号
	);

endmodule