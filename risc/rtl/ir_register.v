module ir_register (
    // 系统相关
    input           clk,        // RISC核心工作时钟
    input           rst_n,      // RISC复位，低电平有效
    // 指令时序控制相关
    input           ld_ir,      // 当ld_ir==1从bus_data上加载指令
    // CPU总线相关
    input   [7:0]   bus_data,   // 数据总线
    // 输出指令
    output  reg [15:0] ir       // 当前指令
);

	localparam
		IR_0 = 1'b0,
		IR_1 = 1'b1;

	reg state;

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			state <= IR_0;
		else
			case (state)
				IR_0: if (ld_ir) state <= IR_1;
				IR_1: if (ld_ir) state <= IR_0;
				default: state <= IR_0;
			endcase
	end

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			ir <= 16'd0;
		else
			case (state)
				IR_0: if (ld_ir) ir[15:8] <= bus_data[7:0];
				IR_1: if (ld_ir) ir[7:0] <= bus_data[7:0];
				default: ir <= ir;
			endcase
	end

endmodule