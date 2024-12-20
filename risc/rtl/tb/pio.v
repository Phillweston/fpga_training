module pio (
    // 系统相关
    input           clk,
    input           rst_n,
    
    // CPU总线
    // 数据总线
    inout   [7:0]   bus_data,   // CPU数据总线
    // 地址总线
    input   [12:0]  bus_addr,   // CPU地址总线
    // 控制总线
    input           wr,         // CPU控制总线写有效信号
    input           rd,         // CPU控制总线读有效信号
    
    output  [7:0]   led
);

	reg [7:0] mem [(13'h1FFF-13'h1FF0):(13'h1FF0-13'h1FF0)]; // 定义存储器块

	reg [7:0] bus_data_r;
	reg       bus_data_link;
	assign    bus_data = bus_data_link ? bus_data_r : 8'hzz;

	always @(posedge clk) begin
		if (rd && (bus_addr >= 13'h1FF0) && (bus_addr <= 13'h1FFF)) begin
			bus_data_r <= mem[bus_addr - 13'h1FF0];
			bus_data_link <= 1'b1;
		end else begin
			bus_data_link <= 1'b0;
		end
	end

	always @(posedge clk) begin
		if (wr && (bus_addr >= 13'h1FF0) && (bus_addr <= 13'h1FFF)) begin
			mem[bus_addr - 13'h1FF0] <= bus_data;
		end
	end

	assign led = mem[13'h1FF0 - 13'h1FF0];

endmodule