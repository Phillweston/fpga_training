module pc_gen (
    // 系统相关
    input           clk,        // RISC核心工作时钟
    input           rst_n,      // RISC复位，低电平有效
    // 指令时序控制相关
    input           en_inc,     // 当en_inc==1时，pc自加1
    input           ld_pc,      // 当ld_pc==1时，pc更新为ir[12:0]
    // 操作地址
    input   [12:0]  ir,         // 操作地址
    // 输出指令指针
    output  reg [12:0] pc       // 指令指针
);

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			pc <= 13'd0;
		else if (en_inc)
			pc <= pc + 1'b1;        // 自加1
		else if (ld_pc)
			pc <= ir;               // 跳转
	end

endmodule