module img_ctl #(
	parameter COL_MAX = 600,
			  ROW_MAX = 400

)
(
	//系统相关
	input						clk,		//视频图像处理时钟
	input						rst_n,		//系统复位
	//系统总线相关
	output						bus_cs_n,	//总线片选
	output						bus_we_o,	//总线写使能
	input						bus_ack_i,	//总线从机应答
	//人机交互
	input						start,		//当start==1表示启动视频图像处理
	output						done,		//当done==1表示当前一次处理处理结束，默认一帧图像处理完成表示结束
	//控制相关
	output						load0,		//load0==1表示加载第1个数据
	output						load1,		//load1==1表示加载第2个数据
	output						load2		//load2==1表示加载第3个数据
	output						en_pipe,	//流水线控制，当en_pipe==1每个运行步骤输出结果
	output						inc_src,	//inc_src==1源存储器偏移地址加1
	output						inc_dec,	//inc_dec==1目标存储器偏移地址加1
	output						rst_a		//当rst_a==1表示存储器区域地址回到初始位置
);
	localparam IDLE	= 3'd0,
	//读3*4数据
	READ4_0	= 3'd1,
	READ4_1	= 3'd2,
	READ4_2 = 3'd3,
	//当前被加载的数据全部运行
	en_run = 3'd4,
	//判断是够要写,如果写的话写目标存储区域
	WRITE = 3'd5;

	reg	[2:0] state;
	reg	[1:0] cnt;
	reg	[7:0] col;
	reg	[8:0] row;
	always @(posedge clk or negedge rst_n)
		if(~rst_n)begin
			cnt     <=   2'd0;
			col     <=   8'd0;
			row     <=   9'd0;
			state   <=	IDLE;end
		else case(state)
			IDLE:
				if (start)
					state <= READ4_0;
			READ4_0:
				if (bus_ack_i)
					state <= READ4_1;
			READ4_1:
				if(bus_ack_i)
					state <= READ4_2;
			READ4_2:
				if(bus_ack_i)
					state <= en_run;
			en_run: begin
				/////////相关计数器计数///////////////////////////
				if (cnt==2'd3) begin
					if (col == (`COL_MAX / 4))
						col <= 8'd0;
					else 
						col <= col + 1'b1;
					cnt <= 2'd0;
				end else 
					cnt <= cnt + 1'b1;
				/////////状态机跳转///////////////////////////
				if (cnt == 3)
					if (col == 0)
						state <= READ4_0;//第一加载运行，流水尚未成功启动，计算结果无效
					else 
						state <= WRITE;//启动完成，流水线稳定和导出运算结果有效
			end

			WRITE: begin
				/////////相关计数器计数///////////////////////////
				if (bus_ack_i & (col == 0))
					if (row == (ROW_MAX - 3))	
						row <= 9'd0;	
					else
						row <= row + 1'b1;

				/////////状态机跳转///////////////////////////
				if (bus_ack_i)
					case(col)
						0:
							if (row == (ROW_MAX - 3))	
								state <= IDLE;//一帧图像处理完成
							else
								state <= READ4_0;//一帧图像处理未完成，但是流水线需要重新启动
						((`COL_MAX / 4) - 1):
							state <= en_run;//流水线即将导出
						default:
							state <= READ4_0;//流水线稳定阶段
					endcase
			end
			default:
				state <= IDLE;
		endcase

	/////////////////系统总线读写并加载////////////////////////////////////////////////////////////////////
	always @(posedge clk or negedge rst_n)
		if(~rst_n) begin	
			bus_cs_n <= 1'b1;	//总线片选
			bus_we_o <= 1'b0;	//总线写使能
		end else case(state)
			READ4_0: begin
				bus_we_o <= 1'b0;
				if (bus_ack_i)
					bus_cs_n <= 1'b1;	//总线片选
				else
					bus_cs_n <= 1'b0;	//总线片选
			end
			READ4_1: begin
				bus_we_o <= 1'b0;
				if (bus_ack_i)
					bus_cs_n <= 1'b1;	//总线片选
				else
					bus_cs_n <= 1'b0;	//总线片选
			end
			READ4_2: begin
				bus_we_o <= 1'b0;
				if (bus_ack_i)
					bus_cs_n <= 1'b1;	//总线片选
				else 
					bus_cs_n <= 1'b0;	//总线片选
			end
			WRITE: begin
				bus_we_o <= 1'b1;
				if (bus_ack_i)
					bus_cs_n <= 1'b1;	//总线片选
				else 
					bus_cs_n <= 1'b0;	//总线片选
			end
			default:
				bus_cs_n <= 1'b1;	//总线片选
		endcase

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			load0 <= 1'b0;
		else if(state == READ4_0) 
			if (bus_ack_i)
				load0 <= 1'b0;	
			else 
				load0 <= 1'b1;
		else 
			load0 <= 1'b0;

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			load1 <= 1'b0;
		else if (state == READ4_1) 
			if (bus_ack_i)
				load1 <= 1'b0;	
			else 
				load1 <= 1'b1;
		else
			load1 <= 1'b0;

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			load2<=  1'b0;
		else if (state == READ4_2) 
			if (bus_ack_i)
				load2 <= 1'b0;	
			else 
				load2 <= 1'b1;
		else
			load2 <= 1'b0;

	////////////////////流水线运行控制////////////////////////////////////////////////////////////////
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			en_pipe <= 1'b0;
		else if (state == en_run)
			en_pipe <= 1'b1;
		else
			en_pipe <= 1'b0;

	//存储器偏移地址控制///////////////////////////////////////////////////////////////////////////
	assign rst_a = state == IDLE;
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			inc_src <= 1'b0;
		else if ((state == READ4_2) & bus_ack_i)
			inc_src <= 1'b1;
		else
			inc_src <= 1'b0;

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			inc_dec <= 1'b0;
		else if ((state == WRITE) & bus_ack_i)
			inc_dec <= 1'b1;
		else 
			inc_dec <= 1'b0;
								
	assign done = (state == WRITE) & bus_ack_i & (col == 0) & (row == (ROW_MAX - 3));
endmodule 