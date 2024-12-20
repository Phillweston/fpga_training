`include  "sdr_param.v"
module sdr_write
(
	//系统相关
	input					clk,	/*系统时钟，也是CK的时钟，默认50mhz
										目前sdr sdram的ck是频率瓶颈为200mhz*/
	
	input					rst_n,		//系统复位
	//用户接口
	input					req_w,		//当req_w==1表示写请求
	output					done_w,		//当done_w==1表示当前写完成
	input [24:0]			laddr_w,	//写操作线性地址，实际读写一般按照线性地址操作，映射有2种
	
	input [((`BL*16)-1):0]	wrdata,		//写突发数据
	
	//Sdr sdram写相关的sdr sdram接口
	output reg [4:0]		cmd_w,	/*	Cke =Cmd_w[4]
										Cs_n= Cmd_w[3]
										ras_n= Cmd_w[2]
										cas_n= Cmd_w[1]
										we_n= Cmd_w[0]*/
	output reg [12:0]		addr_w,		//Sdr sdram接口行列复用地址信号
	inout [15:0]			dq_w,		//Sdr sdram数据信号
	output [15:0]			dqm_w,		//Sdr sdram写掩码
	output reg [1:0]		ba_w		//Bank地址
);

	assign dqm_w = 2'b00;
	localparam IDLE = 2'd0,
			   ON_ROW = 2'd1,
			   WRITE_COL_OFF_ROW = 2'd2;
	reg	[1:0] state;
	reg	[2:0] cnt;
	always @(posedge clk or	negedge	rst_n)
		if(~rst_n) begin
			state <= IDLE;
			cnt	<=3'd0;
		end else case(state)
			IDLE:
				if (req_w)
					state <= ON_ROW;

			ON_ROW:
				if (cnt == `TRCD) begin
					state <= WRITE_COL_OFF_ROW;
					cnt	<= 3'd0;
				end else
					cnt <= cnt + 1'b1;

			WRITE_COL_OFF_ROW:
				if (cnt == (`BL + `TWR + `TRP)) begin
					state <= IDLE;
					cnt	<= 3'd0;
				end else 
					cnt <= cnt + 1'b1;
			default: begin
				state <= IDLE;
				cnt	<= 3'd0;
			end
		endcase

	//////////////////完成标志判断///////////////////////////////////////////////////////////////////////
	assign done_w = (state == WRITE_COL_OFF_ROW) & (cnt == (`BL + `TWR + `TRP));	

	//////////////////sdr  sdram写操作///////////////////////////////////////////////////////////////////////	
	reg [15:0] dq_r;
	reg	dq_link;		
	assign dq_w	= dq_link ? dq_r : 16'hzzzz;		
	always @(posedge clk or negedge	rst_n)
		if (~rst_n)	begin
			cmd_w <= `CMD_INIT;
			addr_w <= 13'd0;
			ba_w <= 2'd0;
			dq_r <= 16'd0;
			dq_link<=1'b0;
		end else case(state)
			ON_ROW:
				if (cnt == 0) begin
					cmd_w <= `CMD_ACTIVE;
					addr_w <= laddr_w[22:10];
					ba_w <= laddr_w[24:23];
					dq_r <= 16'd0;
					dq_link <= 1'b0;
				end else  
					cmd_w <= `CMD_NOP;
			WRITE_COL_OFF_ROW: begin
				if (cnt==0) begin
					cmd_w <= `CMD_WRITE;
					addr_w <= {2'bxx, 1'b1, laddr_w[09:00]};
					ba_w <= laddr_w[24:23];
				end else 
					cmd_w <= `CMD_NOP;
				case (cnt)
					0: begin
						dq_link <= 1'b1;
						dq_r[15:0] <= wrdata[((1*16)-1):(0*16)];
					end
					1: begin
						dq_link <= 1'b1;
						dq_r[15:0] <= wrdata[((2*16)-1):(1*16)];
					end
					2: begin
						dq_link <= 1'b1;
						dq_r[15:0] <= wrdata[((3*16)-1):(2*16)];
					end
					3: begin
						dq_link <= 1'b1;
						dq_r[15:0] <= wrdata[((4*16)-1):(3*16)];
					end
					default:
						dq_link <= 1'b0;
				endcase
			end
			default: begin
				cmd_w <= `CMD_NOP;
				dq_link <= 1'b0;
			end
		endcase
endmodule 