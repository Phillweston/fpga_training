module mem_process (
    // 系统相关
    input           clk,

    // CPU总线
    // 数据总线
    inout   [7:0]   bus_data,   // CPU数据总线
    // 地址总线
    input   [12:0]  bus_addr,   // CPU地址总线
    // 控制总线
    input           rd          // CPU控制总线读有效信号
);

	reg     [7:0]   bus_data_r;
	reg             bus_data_link;
	assign          bus_data = bus_data_link ? bus_data_r : 8'hzz;

	reg     [7:0]   mem [13'h0FFF:13'h0000]; // 定义存储器块

	always @(posedge clk) begin
		if (rd && (bus_addr >= 13'h0000) && (bus_addr <= 13'h0FFF)) begin
			bus_data_r <= mem[bus_addr - 13'h0000];
			bus_data_link <= 1'b1;
		end else begin
			bus_data_link <= 1'b0;
		end
	end

	// mem 初始化
	initial $readmemb("process.dat", mem);

endmodule