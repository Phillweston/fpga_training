module seq_recovery (
    // 系统相关
    input           clk_dx,         // 序列恢复时钟
    input           rst_n,          // 系统复位
    // 编码输入（带噪声）
    input   [2:0]   code_noise,     // [-3:+3]带噪声的编码输入
    // 输出恢复序列
    output  reg     seq_rc,         // 恢复序列
    output  reg     flag_seq_rc     // 当flag_seq_rc==1表示seq_rc有效
);

	`define INIT_SUM 93
	`define GATE (`INIT_SUM + 28)

	wire [30:0] m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21, m22, m23, m24, m25, m26, m27, m28, m29, m30;

	assign m0  = 31'b0010110011111000110111010100001; // 167c6ea1
	assign m1  = 31'b0101100111110001101110101000010; // 2cf8dd42
	assign m2  = 31'b0111010100001001011001111100011; // 3a84b3e3
	assign m3  = 31'b1011001111100011011101010000100; // 59f1ba84
	assign m4  = 31'b1001111100011011101010000100101; // 4f8dd425
	assign m5  = 31'b1110101000010010110011111000110; // 750967c6
	assign m6  = 31'b1100011011101010000100101100111; // 63750967
	assign m7  = 31'b0100101100111110001101110101000; // 259f1ba8
	assign m8  = 31'b0110011111000110111010100001001; // 33e37509
	assign m9  = 31'b0001001011001111100011011101010; // 0967c6ea
	assign m10 = 31'b0011111000110111010100001001011; // 1f1ba84b
	assign m11 = 31'b1111100011011101010000100101100; // 7c6ea12c
	assign m12 = 31'b1101010000100101100111110001101; // 6a12cf8d
	assign m13 = 31'b1010000100101100111110001101110; // 50967c6e
	assign m14 = 31'b1000110111010100001001011001111; // 46ea12cf
	assign m15 = 31'b1001011001111100011011101010000; // 4b3e3750
	assign m16 = 31'b1011101010000100101100111110001; // 5d4259f1
	assign m17 = 31'b1100111110001101110101000010010; // 67c6ea12
	assign m18 = 31'b1110001101110101000010010110011; // 71ba84b3
	assign m19 = 31'b0010010110011111000110111010100; // 12cf8dd4
	assign m20 = 31'b0000100101100111110001101110101; // 04b3e375
	assign m21 = 31'b0111110001101110101000010010110; // 3e375096
	assign m22 = 31'b0101000010010110011111000110111; // 284b3e37
	assign m23 = 31'b1101110101000010010110011111000; // 6ea12cf8
	assign m24 = 31'b1111000110111010100001001011001; // 78dd4259
	assign m25 = 31'b1000010010110011111000110111010; // 4259f1ba
	assign m26 = 31'b1010100001001011001111100011011; // 54259f1b
	assign m27 = 31'b0110111010100001001011001111100; // 3750967c
	assign m28 = 31'b0100001001011001111100011011101; // 212cf8dd
	assign m29 = 31'b0011011101010000100101100111110; // 1ba84b3e
	assign m30 = 31'b0001101110101000010010110011111; // 0dd4259f

	// 求绝对值
	wire [2:0] abs_code_noise;
	assign abs_code_noise = code_noise[2] ? ((~code_noise) + 1'b1) : code_noise;

	localparam M_FIND = 2'd0, // 计算相关性，找到用于解码的m序列
			SYNC  = 2'd1, // 通信同步
			WORK  = 2'd2; // 正常通信

	reg [1:0] state;
	reg [7:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12, sum13, sum14, sum15, sum16, sum17, sum18, sum19, sum20, sum21, sum22, sum23, sum24, sum25, sum26, sum27, sum28, sum29, sum30, sum;
	reg [4:0] cnt;

	always @(posedge clk_dx or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 5'd0;
			state <= M_FIND;
		end else begin
			case (state)
				M_FIND: if (cnt == 30) begin
							if ((sum0 >= `GATE) || (sum1 >= `GATE) || (sum2 >= `GATE) || (sum3 >= `GATE) || (sum4 >= `GATE) || 
								(sum5 >= `GATE) || (sum6 >= `GATE) || (sum7 >= `GATE) || (sum8 >= `GATE) || (sum9 >= `GATE) || 
								(sum10 >= `GATE) || (sum11 >= `GATE) || (sum12 >= `GATE) || (sum13 >= `GATE) || (sum14 >= `GATE) || 
								(sum15 >= `GATE) || (sum16 >= `GATE) || (sum17 >= `GATE) || (sum18 >= `GATE) || (sum19 >= `GATE) || 
								(sum20 >= `GATE) || (sum21 >= `GATE) || (sum22 >= `GATE) || (sum23 >= `GATE) || (sum24 >= `GATE) || 
								(sum25 >= `GATE) || (sum26 >= `GATE) || (sum27 >= `GATE) || (sum28 >= `GATE) || (sum29 >= `GATE) || 
								(sum30 >= `GATE)) begin
								state <= SYNC;
							end
							cnt <= 5'd0;
						end else begin
							cnt <= cnt + 1'b1;
						end
				SYNC: if (cnt == 30) begin
						if (sum < `INIT_SUM) state <= WORK;
						cnt <= 5'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				WORK: if (cnt == 30) begin
						cnt <= 5'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				default: state <= M_FIND;
			endcase
		end
	end

	// 计算m序列相关性
	reg [30:0] mxx;
	always @(posedge clk_dx or negedge rst_n) begin
		if (~rst_n) begin
			sum0 <= `INIT_SUM;
			sum1 <= `INIT_SUM;
			sum2 <= `INIT_SUM;
			sum3 <= `INIT_SUM;
			sum4 <= `INIT_SUM;
			sum5 <= `INIT_SUM;
			sum6 <= `INIT_SUM;
			sum7 <= `INIT_SUM;
			sum8 <= `INIT_SUM;
			sum9 <= `INIT_SUM;
			sum10 <= `INIT_SUM;
			sum11 <= `INIT_SUM;
			sum12 <= `INIT_SUM;
			sum13 <= `INIT_SUM;
			sum14 <= `INIT_SUM;
			sum15 <= `INIT_SUM;
			sum16 <= `INIT_SUM;
			sum17 <= `INIT_SUM;
			sum18 <= `INIT_SUM;
			sum19 <= `INIT_SUM;
			sum20 <= `INIT_SUM;
			sum21 <= `INIT_SUM;
			sum22 <= `INIT_SUM;
			sum23 <= `INIT_SUM;
			sum24 <= `INIT_SUM;
			sum25 <= `INIT_SUM;
			sum26 <= `INIT_SUM;
			sum27 <= `INIT_SUM;
			sum28 <= `INIT_SUM;
			sum29 <= `INIT_SUM;
			sum30 <= `INIT_SUM;
			mxx <= 31'd0;
		end else if (state == M_FIND) begin
			// m0解码
			if (cnt == 30) begin
				sum0 <= `INIT_SUM;
			end else if (code_noise[2] == m0[cnt]) begin
				sum0 <= sum0 + abs_code_noise;
			end else begin
				sum0 <= sum0 - abs_code_noise;
			end

			// ...

			// m30解码
			if (cnt == 30) begin
				sum30 <= `INIT_SUM;
			end else if (code_noise[2] == m30[cnt]) begin
				sum30 <= sum30 + abs_code_noise;
			end else begin
				sum30 <= sum30 - abs_code_noise;
			end

			if (cnt == 30) begin
				if (sum0 >= `GATE) mxx <= m0;
				if (sum1 >= `GATE) mxx <= m1;
				if (sum2 >= `GATE) mxx <= m2;
				if (sum3 >= `GATE) mxx <= m3;
				if (sum4 >= `GATE) mxx <= m4;
				// ...
				if (sum30 >= `GATE) mxx <= m30;
			end
		end
	end

	// 解码
	always @(posedge clk_dx or negedge rst_n) begin
		if (~rst_n) begin
			sum <= `INIT_SUM;
		end else begin
			case (state)
				SYNC: if (cnt == 30) begin
						sum <= `INIT_SUM;
					end else if (code_noise[2] == mxx[cnt]) begin
						sum <= sum + abs_code_noise;
					end else begin
						sum <= sum - abs_code_noise;
					end
				WORK: if (cnt == 30) begin
						sum <= `INIT_SUM;
					end else if (code_noise[2] == mxx[cnt]) begin
						sum <= sum + abs_code_noise;
					end else begin
						sum <= sum - abs_code_noise;
					end
				default: sum <= `INIT_SUM;
			endcase
		end
	end

	always @(posedge clk_dx or negedge rst_n) begin
		if (~rst_n) begin
			seq_rc <= 1'b0;       // 恢复序列
			flag_seq_rc <= 1'b0;  // 当flag_seq_rc==1表示seq_rc有效
		end else if ((state == WORK) & (cnt == 30)) begin
			if (sum >= `INIT_SUM) begin
				seq_rc <= 1'b1;   // 恢复序列
				flag_seq_rc <= 1'b1;
			end else begin
				seq_rc <= 1'b0;   // 恢复序列
				flag_seq_rc <= 1'b1;
			end
		end
	end

endmodule