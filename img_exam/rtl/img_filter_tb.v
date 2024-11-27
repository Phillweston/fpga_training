`timescale 1ns/1ns

module img_filter_tb;
	reg [7:0] mem [((600 * 400) - 1) : 0];
	initial $readmemh("img_src.dat", mem);

	reg	clk, rst_n;
	initial begin
		clk = 0;
		rst_n = 0;
		#53	rst_n = 1;
	end

	always #2 clk = ~clk;
	reg [3:0] cnt;
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			cnt <= 4'd0;
		else 
			cnt <= cnt + 1'b1;
	//邻域像素点
	reg [7:0] p00;	//邻域1*1像素点
	reg [7:0] p01;	//邻域1*2像素点
	reg [7:0] p02;	//邻域1*3像素点
	reg [7:0] p10;	//领域2*1像素点
	reg [7:0] p11;	//领域2*2像素点，中心像素点
	reg [7:0] p12;	//领域2*3像素点
	reg [7:0] p20;	//领域3*1像素点
	reg [7:0] p21;	//领域3*2像素点
	reg [7:0] p22;	//领域3*3像素点
	//输出平均值
	wire [7:0] oval;	//邻域平均值

	//中心像素点计数
	reg	[9:0] col, row;
	always @(posedge clk or negedge rst_n)
		if (~rst_n) begin
			col <= 0;
			row <= 0;
		end else if (cnt == 15)
			if (col == (600 - 3))begin
				if (row == (400 - 3))
					row <= 0;
				else
					row <= row + 1'b1;
				col <= 0;
			end else 
				col <= col + 1'b1;
	//读原图像数据
	reg	[17:0] addr_mem;
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			addr_mem <= 18'd0;
		else case (cnt)
			0: addr_mem <= ((row + 0) * 600) + col + 0;		//p00
			1: addr_mem <= ((row + 0) * 600) + col + 1;		//p01
			2: addr_mem <= ((row + 0) * 600) + col + 2;		//p02
			3: addr_mem <= ((row + 1) * 600) + col + 0;		//p10
			4: addr_mem <= ((row + 1) * 600) + col + 1;		//p11
			5: addr_mem <= ((row + 1) * 600) + col + 2;		//p12
			6: addr_mem <= ((row + 2) * 600) + col + 0;		//p20
			7: addr_mem <= ((row + 2) * 600) + col + 1;		//p21
			8: addr_mem <= ((row + 2) * 600) + col + 2;		//p22
			default: addr_mem <= addr_mem;
		endcase				
	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p00 <= 0;
		else if (cnt == 1)
			p00 <= mem[addr_mem];
								
	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p01 <= 0;
		else if (cnt == 2)
			p01 <= mem[addr_mem];

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p02 <= 0;
		else if (cnt == 3)
			p02 <= mem[addr_mem];	

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p10 <= 0;
		else if (cnt == 4)
			p10 <= mem[addr_mem];	

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p11 <= 0;
		else if (cnt == 5)
			p11 <= mem[addr_mem];	

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p12 <= 0;
		else if (cnt == 6)
			p12 <= mem[addr_mem];	

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p20 <= 0;
		else if (cnt == 7)
			p20 <= mem[addr_mem];	

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p21 <= 0;
		else if (cnt == 8)
			p21 <= mem[addr_mem];	

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			p22 <= 0;
		else if (cnt == 9)
			p22 <= mem[addr_mem];	

	////////////////文件打印//////////////////////////////////////////////////////
	integer fid;
	initial fid = $fopen("img_dec.dat");
	always @(posedge clk)
		if (cnt == 15)
			if (col == (600 - 3))
				$fwrite(fid, "%d\n", oval);
			else 
				$fwrite(fid, "%d ", oval);
	reg	stop;

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			stop <= 0;
		else if ((cnt == 15) & (col == (600 - 3)) & (row == (400 - 3)))
			stop <= 1;	

	always @(posedge clk)
		if (stop) begin
			$fclose(fid);
			$stop;
		end

	img_filter img_filter_ins
	(
		//邻域像素点
		.p00(p00),	//邻域1*1像素点
		.p01(p01),	//邻域1*2像素点
		.p02(p02),	//邻域1*3像素点
		.p10(p10),	//领域2*1像素点
		.p11(p11),	//领域2*2像素点，中心像素点
		.p12(p12),	//领域2*3像素点
		.p20(p20),	//领域3*1像素点
		.p21(p21),	//领域3*2像素点
		.p22(p22),	//领域3*3像素点
		//输出平均值
		.oval(oval)	//邻域平均值
	);
endmodule