`include  "sdr_param.v"
module sdr_init
(
	//系统相关
	input			clk,	/*系统时钟，也是CK的时钟，默认50mhz
								目前sdr sdram的ck是频率瓶颈为200mhz*/					
	input			rst_n,	//系统复位
	//用户接口
	input			req_init,//当req_init==1表示初始化请求
	output			done_init,//当done_init==1表示当前初始化完成
	//Sdr sdram初始化相关的sdr sdram接口
	output reg [4:0] cmd_init,/*		Cke 		= Cmd_init[4]
									Cs_n		= Cmd_init[3]
									ras_n		= Cmd_init[2]
									cas_n		= Cmd_init[1]
									we_n		= Cmd_init[0]*/
	output reg [12:0] addr_init	//Sdr sdram接口行列复用地址信号
);
	localparam  IDLE = 3'd0,
				CHECK_MYSELF = 3'd1,
				PR_SNT = 3'd2, // 关闭所有banl下的行开关电路
				PR_RF0 = 3'd3, // 电容初始化
				PR_RF1 = 3'd4, // 电容初始化
				LMR_RF0 = 3'd5; // 配置工作模式

	reg [2:0] state;
	reg [12:0] cnt;

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 13'd0;
			state <= IDLE;
		end else begin
			case (state)
				IDLE:
					if (req_init)
						state <= CHECK_MYSELF;
				CHECK_MYSELF:
					if (cnt == `CK_MYSELF) begin
						state <= PR_SNT;
						cnt <= 13'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				PR_SNT:
					if (cnt == `TRP) begin
						state <= PR_RF0;
						cnt <= 13'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				PR_RF0:
					if (cnt == `TRFC) begin
						state <= PR_RF1;
						cnt <= 13'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				PR_RF1:
					if (cnt == `TRFC) begin
						state <= LMR_RF0;
						cnt <= 13'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				LMR_RF0:
					if (cnt == `TMRD) begin
						state <= IDLE;
						cnt <= 13'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				default:
					begin
						state <= IDLE;
						cnt <= 13'd0;
					end
			endcase
		end
	end

	//////////////////完成标志判断///////////////////////////////////////////////////////////////////////
	assign done_init = (state == LMR_RF0) & (cnt == `TMRD);

	//////////////////sdr sdram初始化设置///////////////////////////////////////////////////////////////////////
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cmd_init <= `CMD_INIT;
			addr_init <= 13'd0;
		end else begin
			case (state)
				PR_SNT:
					if (cnt == 0) begin
						cmd_init <= `CMD_PR; // 发送自动预充电命令
						addr_init <= 13'h1FFF;
					end else begin
						cmd_init <= `CMD_NOP;
					end
				PR_RF0:
					if (cnt == 0) begin
						cmd_init <= `CMD_RF; // 发送刷新命令
					end else begin
						cmd_init <= `CMD_NOP;
					end
				PR_RF1:
					if (cnt == 0) begin
						cmd_init <= `CMD_RF; // 发送刷新命令
					end else begin
						cmd_init <= `CMD_NOP;
					end
				LMR_RF0:
					if (cnt == 0) begin
						cmd_init <= `CMD_LMR; // 发送模式寄存器命令
						addr_init <= {
							3'b000,
							1'b0,    // 支持突发
							2'b00,   // 标准模式
							3'b011,  // CL=3
							1'b0,    // 顺序突发
							3'b010   // BL=4
						};
					end else begin
						cmd_init <= `CMD_NOP;
					end
				default:
					cmd_init <= `CMD_NOP;
			endcase
		end
	end
endmodule 