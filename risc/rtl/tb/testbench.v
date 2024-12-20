`timescale 1ns / 1ps

module testbench;
	reg clk;        // RISC核心工作时钟
	reg rst_n;      // RISC复位，低电平有效

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

	wire [7:0] led;

	mem_process mem_process_ins (
		// 系统相关
		.clk(clk),
		// CPU总线
		// 数据总线
		.bus_data(bus_data),    // CPU数据总线
		// 地址总线
		.bus_addr(bus_addr),    // CPU地址总线
		// 控制总线
		.rd(rd)                 // CPU控制总线读有效信号
	);

	mem_run mem_run_ins (
		// 系统相关
		.clk(clk),
		// CPU总线
		// 数据总线
		.bus_data(bus_data),    // CPU数据总线
		// 地址总线
		.bus_addr(bus_addr),    // CPU地址总线
		// 控制总线
		.wr(wr),                // CPU控制总线写有效信号
		.rd(rd)                 // CPU控制总线读有效信号
	);

	pio pio_ins (
		// 系统相关
		.clk(clk),
		.rst_n(rst_n),
		// CPU总线
		// 数据总线
		.bus_data(bus_data),    // CPU数据总线
		// 地址总线
		.bus_addr(bus_addr),    // CPU地址总线
		// 控制总线
		.wr(wr),                // CPU控制总线写有效信号
		.rd(rd),                // CPU控制总线读有效信号
		.led(led)
	);

	risc risc_ins (
		.clk(clk),              // RISC核心工作时钟
		.rst_n(rst_n),          // RISC复位，低电平有效
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