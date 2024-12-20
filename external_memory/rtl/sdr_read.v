`include "sdr_param.v"

module sdr_read (
    // 系统相关
    input           clk,        // 系统时钟，也是CK的时钟，默认50mhz，目前sdr sdram的ck是频率瓶颈为200mhz
    input           rst_n,      // 系统复位
    // 用户接口
    input           req_r,      // 当req_r==1表示读请求
    output          done_r,     // 当done_r==1表示当前读完成
    input  [24:0]   laddr_r,    // 写操作线性地址，实际读写一般按照线性地址操作，映射有2种
    output reg [((`BL*16)-1):0] rddata, // 读突发数据
    // Sdr sdram写相关的sdr sdram接口
    output reg [4:0] cmd_r,     /* Cke =Cmd_r[4]
                                   Cs_n= Cmd_r[3]
                                   ras_n= Cmd_r[2]
                                   cas_n= Cmd_r[1]
                                   we_n= Cmd_r[0] */
    output reg [12:0] addr_r,   // Sdr sdram接口行列复用地址信号
    inout  [15:0]    dq_r,      // Sdr sdram数据信号
    output [15:0]    dqm_r,     // Sdr sdram读掩码
    output reg [1:0] ba_r       // Bank地址
);

	localparam IDLE = 2'd0, 			// 空闲
			   ON_ROW = 2'd1, 			// 激活我们要写入存储器对应bank下的行
			   READ_COL_OFF_ROW = 2'd2; // 读数据同时启动自动预充电，addr_r[10]==1

	reg [1:0] state;
	reg [3:0] cnt;

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 4'd0;
			state <= IDLE;
		end else begin
			case (state)
				IDLE:
					if (req_r)
						state <= ON_ROW;
				ON_ROW:
					if (cnt == `TRCD) begin
						state <= READ_COL_OFF_ROW;
						cnt <= 4'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				READ_COL_OFF_ROW: 
					if (cnt == (`BL + `CL + `TRP)) begin
						state <= IDLE;
						cnt <= 4'd0;
					end else begin
						cnt <= cnt + 1'b1;
					end
				default: begin
					cnt <= 4'd0;
					state <= IDLE;
				end
			endcase
		end
	end

	/////////////////////读完成标志判断/////////////////////////////////////////////////////////////////////////
	assign done_r = (state == READ_COL_OFF_ROW) & (cnt == (`BL + `CL + `TRP));

	////////////////////////读操作接口控制//////////////////////////////////////////////////////////////////
	assign dqm_r = 2'b00; // 默认不掩码

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cmd_r <= `CMD_INIT;
			ba_r <= 2'd0;
			addr_r <= 13'd0;
		end else begin
			case (state)
				ON_ROW:
					if (cnt == 0) begin
						cmd_r <= `CMD_ACTIVE;
						ba_r <= laddr_r[24:23]; // laddr_r={ba[1:0],addr_r[12:0],addr_r[9:0]}
						addr_r <= laddr_r[22:10];
					end else begin
						cmd_r <= `CMD_NOP;
					end
				READ_COL_OFF_ROW:
					if (cnt == 0) begin
						cmd_r <= `CMD_READ;
						ba_r <= laddr_r[24:23]; // laddr_r={ba[1:0],addr_r[12:0],addr_r[9:0]}
						addr_r <= {2'bxx, 1'b1, laddr_r[09:00]};
					end else begin
						cmd_r <= `CMD_NOP;
					end
				default:
					cmd_r <= `CMD_NOP;
			endcase
		end
	end

	////////////////////////////读数据//////////////////////////////////////////////////
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			rddata <= 63'd0;
		else if (state == READ_COL_OFF_ROW) begin
			case (cnt)
				(1 + `CL + 0): rddata[((16*1)-1):(16*0)] <= dq_r[15:00];
				(1 + `CL + 1): rddata[((16*2)-1):(16*1)] <= dq_r[15:00];
				(1 + `CL + 2): rddata[((16*3)-1):(16*2)] <= dq_r[15:00];
				(1 + `CL + 3): rddata[((16*4)-1):(16*3)] <= dq_r[15:00];
				default: rddata <= rddata;
			endcase
		end
	end

endmodule