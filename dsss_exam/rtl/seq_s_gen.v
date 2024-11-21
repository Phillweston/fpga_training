module seq_s_gen (
    // 系统相关
    input           clk_c,      // 信息时钟
    input           rst_n,      // 系统复位
    // 输入信息序列
    input           info,       // 信息序列
    output  reg     ready_info, // 当ready_info==1表示准备接收info
    // 输出待调制序列
    output  reg     seq_s,      // 待调制序列
    output  reg     flag_seq_s  // 当flag_seq_s==1表示seq_s有效
);

	localparam  BIT_SYNC = 2'd0,
				PK_HEDAD = 2'd1,
				HMM_INFO = 2'd2,
				HMM_JD   = 2'd3;

	reg [1:0] state;
	reg [3:0] cnt;
	reg [6:0] cnt_hmm;

	always @(posedge clk_c or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 4'd0;
			cnt_hmm <= 7'd0;
			state <= BIT_SYNC;
		end else begin
			case (state)
				BIT_SYNC: if (cnt == 4'd10) begin
							state <= PK_HEDAD;
							cnt <= 4'd0;
						end else begin
							cnt <= cnt + 1'b1;
						end
				PK_HEDAD: if (cnt == 4'd6) begin
							state <= HMM_INFO;
							cnt <= 4'd0;
						end else begin
							cnt <= cnt + 1'b1;
						end
				HMM_INFO: if (cnt == 4'd3) begin
							state <= HMM_JD;
							cnt <= 4'd0;
						end else begin
							cnt <= cnt + 1'b1;
						end
				HMM_JD: if (cnt == 4'd2) begin
							if (cnt_hmm == 7'd127) begin
								state <= PK_HEDAD;
								cnt_hmm <= 7'd0;
							end else begin
								cnt_hmm <= cnt_hmm + 1'b1;
								state <= HMM_INFO;
							end
							cnt <= 4'd0;
						end else begin
							cnt <= cnt + 1'b1;
						end
				default: state <= BIT_SYNC;
			endcase
		end
	end

	//////////////////////计算汉明码监督位///////////////////////////////////////////////////////
	reg d6, d5, d4, d3;
	wire d2, d1, d0;

	assign d2 = d6 ^ d5 ^ d4;
	assign d1 = d6 ^ d5 ^ d3;
	assign d0 = d6 ^ d4 ^ d3;

	always @(posedge clk_c or negedge rst_n) begin
		if (~rst_n) begin
			d3 <= 1'b0;
			d4 <= 1'b0;
			d5 <= 1'b0;
			d6 <= 1'b0;
		end else begin
			if ((state == HMM_INFO) & (cnt == 0))
				d3 <= info;
			if ((state == HMM_INFO) & (cnt == 1))
				d4 <= info;
			if ((state == HMM_INFO) & (cnt == 2))
				d5 <= info;
			if ((state == HMM_INFO) & (cnt == 3))
				d6 <= info;
		end
	end

	////////////////////////原始待调制序列生成////////////////////////////////////////////////////////
	always @(posedge clk_c or negedge rst_n) begin
		if (~rst_n) begin
			seq_s <= 1'b0;        // 待调制序列
			flag_seq_s <= 1'b0;   // 当flag_seq_s==1表示seq_s有效
		end else begin
			case (state)
				BIT_SYNC: if (cnt == 10) begin
							seq_s <= 1'b0;    // 待调制序列
							flag_seq_s <= 1'b1;
						end else begin
							seq_s <= 1'b1;    // 待调制序列
							flag_seq_s <= 1'b1;
						end
				PK_HEDAD: begin
							seq_s <= 1'b0;    // 待调制序列
							flag_seq_s <= 1'b1;
						end
				HMM_INFO: begin
							seq_s <= info;
							flag_seq_s <= 1'b1;
						end
				HMM_JD: case (cnt)
						0: begin seq_s <= d0; flag_seq_s <= 1'b1; end
						1: begin seq_s <= d1; flag_seq_s <= 1'b1; end
						2: begin seq_s <= d2; flag_seq_s <= 1'b1; end
						default: flag_seq_s <= 1'b0;
					endcase
				default: flag_seq_s <= 1'b0;
			endcase
		end
	end

	always @(posedge clk_c or negedge rst_n) begin
		if (~rst_n)
			ready_info <= 1'b0;
		else begin
			case (state)
				PK_HEDAD: if (cnt == 5) ready_info <= 1'b1;
				HMM_INFO: if (cnt == 2) ready_info <= 1'b0;
				HMM_JD: if ((cnt == 1) & (cnt_hmm != 7'd127)) ready_info <= 1'b1;
				default: ready_info <= ready_info;
			endcase
		end
	end

endmodule