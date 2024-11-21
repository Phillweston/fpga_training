module seq_x_gen (
    // 系统相关
    input           clk_cx,     // 载波序列时钟
    input           rst_n,      // 系统复位
    // 输出待调制序列
    output  reg     seq_x,      // 载波
    output  reg     flag_seq_x  // 当flag_seq_x==1表示seq_x有效
);

	// 初值为1序列发生器电路
	reg [4:0] A40_1;

	always @(posedge clk_cx or negedge rst_n) begin
		if (~rst_n) begin
			flag_seq_x <= 1'b0;
			seq_x <= 1'b0;
			A40_1 <= 5'd1; // 初值为1
		end else begin
			A40_1 <= {(A40_1[0] ^ A40_1[3]), A40_1[4:1]};
			seq_x <= A40_1[0];
			flag_seq_x <= 1'b1;
		end
	end

endmodule