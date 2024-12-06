module memory  #(
	parameter BASE = 32'h0000_0000,
			  COL_MAX =	600,
			  ROW_MAX =	400
)
(
	//系统相关
	input						clk,	//系统时钟
	input						rst_n,	//系统复位
	//系统总线相关
	input						bus_cs_n_i,	//系统总线片选，低电平有效
	input						bus_we_i,	/*系统总线写使能
											bus_we_i
											1：写
											0：读*/
	input [31:0]				bus_addr_i,	//系统总线地址
	output reg					bus_ack_o,	//从机应答，当bus_ack_i==1表示从机响应
	output reg [31:0]			bus_data_o,	//系统总线数据信号
	input [31:0]				bus_data_i
);
	reg [7:0] mem [32'h7FFF_FFFF:32'h0000_0000];
	////////////////////////存储器读写(突发读写)////////////////////////////////////
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)
			bus_data_o <= 32'd0;
		else if (~bus_cs_n_i)
			if (bus_we_i) begin
				mem[(bus_addr_i - BASE) + 0] <= bus_data_i[07:00];
				mem[(bus_addr_i - BASE) + 1] <= bus_data_i[15:08];
				mem[(bus_addr_i - BASE) + 2] <= bus_data_i[23:16];
				mem[(bus_addr_i - BASE) + 3] <= bus_data_i[31:24];
			end else
				bus_data_o <= {mem[(bus_addr_i - BASE) + 0],
							   mem[(bus_addr_i - BASE) + 1],
							   mem[(bus_addr_i - BASE) + 2],
							   mem[(bus_addr_i - BASE) + 3]};
		
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)	
			bus_ack_o <= 1'b0;
		else if ((~bus_cs_n_i) & (~bus_ack_o))
			bus_ack_o <= 1'b1;
		else 
			bus_ack_o <= 1'b0;
		
	////////////////////////文件打印/////////////////////////////////////////////////////////////
	integer	fid;
	initial	fid = $fopen("img_src.dat");

	integer	col, row;
	always @(posedge clk or negedge rst_n)
		if (~rst_n) begin
			col <= 0;
			row <= 0;
		end else if ((~bus_cs_n_i) & bus_we_i & bus_ack_o)//写成功的条件
			if (col == ((COL_MAX / 4) - 1)) begin
				if (row == (ROW_MAX - 3))
					row <= 0;
				else
					row <= row + 1'b1;
				col <= 0;
			end else
				col <= col + 1'b1;

	reg	stop;
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)
			stop <= 0;
		else if ((~bus_cs_n_i) & bus_we_i & bus_ack_o &
				 (col == ((COL_MAX / 4) - 1)) & (row == (ROW_MAX - 3)))//写成功的条件
			stop <= 1;

	always @(posedge clk)
		if (stop) begin
			$fclose(fid);
			$stop;
		end

	always @(posedge clk)
		if ((~bus_cs_n_i) & bus_we_i & bus_ack_o)//写成功的条件
			case (col)
				0:
					$fwrite(fid,"%d %d %d ", bus_data_i[15:08], bus_data_i[23:16], bus_data_i[31:24]);//流水线启动
				(col == ((COL_MAX / 4) - 1)):
					$fwrite(fid,"%d %d %d\n", bus_data_i[07:00], bus_data_i[15:08], bus_data_i[23:16]);//流水线导出
				default:
					$fwrite(fid,"%d %d %d %d ", bus_data_i[07:00], bus_data_i[15:08], bus_data_i[23:16], bus_data_i[31:24]);//流水线稳定
			endcase
endmodule