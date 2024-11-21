module tz_code (
    // 输入载波序列
    input           seq_x,      // 载波序列，高频宽带序列
    input           flag_seq_x, // 当flag_seq_x ==1表示seq_x有效
    // 输出待调制序列
    input           seq_s,      // 待调制序列，低频窄带序列
    input           flag_seq_s, // 当flag_seq_s==1表示seq_s有效
    // 输出PCM码
    output  reg [2:0] code      // PCM编码，默认精度3
);

	wire tz; // 已经调制的序列，宽带高频
	assign tz = seq_x ^ seq_s; // tz = seq_x + seq_s

	always @(*) begin
		if (flag_seq_x & flag_seq_s) begin
			if (tz)
				code = 3'b001; // +1
			else
				code = 3'b111; // -1
		end else begin
			code = 3'b000; // 0 // 解码的时候采用统计法，因此这里为0
		end
	end

endmodule