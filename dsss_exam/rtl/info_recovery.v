module info_recovery (
    // 系统相关
    input           clk_d,          // 信息时钟
    input           rst_n,          // 系统复位，低电平有效
    // 扩频序列恢复有关
    input           seq_rc,         // 扩频恢复的序列
    input           flag_seq_rc,    // 当flag_seq_rc==1表示seq_rc有效
    // 有效信息输出
    output  reg [7:0] info_data,    // 有效信息,默认信息元位字节
    output  reg      flag_info_data // 当flag_info_data==1表示info_data有效
);

	//////////////////串转并/////////////////////////////////////
	reg [6:0] rv_7bit; // 把串行恢复的序列转换为7比特数据，该寄存器保存7比特数据
	reg       flag_rv_7bit; // 当flag_rv_7bit==1表示rv_7bit有效
	reg       d6, d5, d4, d3, d1, d0;
	reg [2:0] cnt;

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			cnt <= 3'd0;
		else if (flag_seq_rc) begin
			if (cnt == 3'd6)
				cnt <= 3'd0;
			else
				cnt <= cnt + 1'b1;
		end
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			d3 <= 1'b0;
		else if (flag_seq_rc & (cnt == 3'd0))
			d3 <= seq_rc;
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			d4 <= 1'b0;
		else if (flag_seq_rc & (cnt == 3'd1))
			d4 <= seq_rc;
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			d5 <= 1'b0;
		else if (flag_seq_rc & (cnt == 3'd2))
			d5 <= seq_rc;
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			d6 <= 1'b0;
		else if (flag_seq_rc & (cnt == 3'd3))
			d6 <= seq_rc;
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			d0 <= 1'b0;
		else if (flag_seq_rc & (cnt == 3'd4))
			d0 <= seq_rc;
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			d1 <= 1'b0;
		else if (flag_seq_rc & (cnt == 3'd5))
			d1 <= seq_rc;
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n) begin
			flag_rv_7bit <= 1'b0;
			rv_7bit <= 7'd0;
		end else if (flag_seq_rc & (cnt == 3'd6)) begin
			flag_rv_7bit <= 1'b1;
			rv_7bit <= {d6, d5, d4, d3, seq_rc, d1, d0};
		end else
			flag_rv_7bit <= 1'b0;
	end

	//////////////////////////纠错//////////////////////////////////////////////////////////////////////
	reg [3:0] hmm_inf4_crect;
	wire      s1, s2, s3;

	assign s1 = rv_7bit[6] ^ rv_7bit[5] ^ rv_7bit[4] ^ rv_7bit[2];
	assign s2 = rv_7bit[6] ^ rv_7bit[5] ^ rv_7bit[3] ^ rv_7bit[1];
	assign s3 = rv_7bit[6] ^ rv_7bit[4] ^ rv_7bit[3] ^ rv_7bit[0];

	always @(*) begin
		case ({s1, s2, s3})
			3'b011: hmm_inf4_crect = {rv_7bit[6], rv_7bit[5], rv_7bit[4], ~rv_7bit[3]};
			3'b101: hmm_inf4_crect = {rv_7bit[6], rv_7bit[5], ~rv_7bit[4], rv_7bit[3]};
			3'b110: hmm_inf4_crect = {rv_7bit[6], ~rv_7bit[5], rv_7bit[4], rv_7bit[3]};
			3'b111: hmm_inf4_crect = {~rv_7bit[6], rv_7bit[5], rv_7bit[4], rv_7bit[3]};
			default: hmm_inf4_crect = {rv_7bit[6], rv_7bit[5], rv_7bit[4], rv_7bit[3]};
		endcase
	end

	////////////////////////////输出有效信息/////////////////////////////////////////////////////////
	localparam PK_HEDA    = 2'd0,
			HMM_INF4_1 = 2'd1,
			HMM_INF4_2 = 2'd2;

	reg [1:0] state;
	reg [5:0] cnt_info;

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n) begin
			cnt_info <= 6'd0;
			state <= PK_HEDA;
		end else begin
			case (state)
				PK_HEDA: if (flag_rv_7bit) state <= HMM_INF4_1;
				HMM_INF4_1: if (flag_rv_7bit) state <= HMM_INF4_2;
				HMM_INF4_2: if (flag_rv_7bit) begin
								if (cnt_info == 63) begin
									state <= PK_HEDA;
									cnt_info <= 6'd0;
								end else begin
									state <= HMM_INF4_1;
									cnt_info <= cnt_info + 1'b1;
								end
							end
				default: state <= PK_HEDA;
			endcase
		end
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			info_data <= 8'd0; // 有效信息,默认信息元位字节
		else begin
			case (state)
				HMM_INF4_1: if (flag_rv_7bit) info_data[3:0] <= hmm_inf4_crect[3:0];
				HMM_INF4_2: if (flag_rv_7bit) info_data[7:4] <= hmm_inf4_crect[3:0];
				default: info_data <= info_data;
			endcase
		end
	end

	always @(posedge clk_d or negedge rst_n) begin
		if (~rst_n)
			flag_info_data <= 1'b0; // 当flag_info_data==1表示info_data有效
		else if ((state == HMM_INF4_2) & flag_rv_7bit)
			flag_info_data <= 1'b1;
		else
			flag_info_data <= 1'b0;
	end

endmodule