module top (
    input           clk,
    input   [3:0]   din,
    output  [7:0]   dout,
    // 输出选择时钟
    input           en_clk,
    output          clk_o,
    // SPI从机CPOL=0,CPHA=0
    input           cs_n,
    input           scl,
    input           sda,
    output          tx
);

	wire clk_50mhz;
	wire rst_n;

	wire rd_clk;
	wire rd_en;
	wire [7:0] rddata;
	wire empty;

	multycycle_clock_en multycycle_clock_en_ins (
		.clk(clk_50mhz),
		.rst_n(rst_n),
		.din(din),
		.dout(dout)
	);

	clock_constraints clock_constraints_ins (
		.clk(clk),
		.rst_n(rst_n),
		// 输出系统时钟
		.clk_50mhz(clk_50mhz),
		// 输出选择时钟
		.en_clk(en_clk),
		.clk_o(clk_o)
		// output clk_1mhz_20mhz
	);

	fault_path fault_path_ins (
		// 系统相关信号
		.rst_n(rst_n),
		// SPI从机CPOL=0,CPHA=0
		.cs_n(cs_n),
		.scl(scl),
		.sda(sda),
		// 缓存读取数据
		.rd_clk(rd_clk),
		.rd_en(rd_en),
		.rddata(rddata),
		.empty(empty)
	);

	logic_entry logic_entry_ins (
		.clk_50mhz(clk_50mhz),
		.rst_n(rst_n),
		// 缓存读取数据
		.rd_clk(rd_clk),
		.rd_en(rd_en),
		.rddata(rddata),
		.empty(empty),
		.tx(tx)
	);

endmodule