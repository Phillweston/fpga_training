module crc_gen
(
	input						clk,
	input						rst_n,				
	input						en,//当==1计算CRC
	input	[7:0]				data,
		
	output  reg [4:0]			crc
);
	//第1次
	wire [4:0] crc_nex0;
	wire fd0;
	assign fd0 = crc[4] ^ data[7];
	assign crc_nex0[0] = fd0;
	assign crc_nex0[1] = crc[0];
	assign crc_nex0[2] = crc[1];
	assign crc_nex0[3] = crc[2] ^ fd0;
	assign crc_nex0[4] = crc[3];

	//第2次
	wire [4:0] crc_nex1;
	wire fd1;
	assign fd1 = crc_nex0[4] ^ data[6];
	assign crc_nex1[0] = fd1;
	assign crc_nex1[1] = crc_nex0[0];
	assign crc_nex1[2] = crc_nex0[1];
	assign crc_nex1[3] = crc_nex0[2] ^ fd1;
	assign crc_nex1[4] = crc_nex0[3];

	//第3次
	wire [4:0] crc_nex2;
	wire fd2;
	assign fd2 = crc_nex1[4] ^ data[5];
	assign crc_nex2[0] = fd2;
	assign crc_nex2[1] = crc_nex1[0];
	assign crc_nex2[2] = crc_nex1[1];
	assign crc_nex2[3] = crc_nex1[2] ^ fd2;
	assign crc_nex2[4] = crc_nex1[3];

	//第4次
	wire [4:0] crc_nex3;
	wire fd3;
	assign fd3 = crc_nex2[4] ^ data[4];
	assign crc_nex3[0] = fd3;
	assign crc_nex3[1] = crc_nex2[0];
	assign crc_nex3[2] = crc_nex2[1];
	assign crc_nex3[3] = crc_nex2[2] ^ fd3;
	assign crc_nex3[4] = crc_nex2[3];

	//第5次
	wire [4:0] crc_nex4;
	wire fd4;
	assign fd4 = crc_nex3[4] ^ data[3];
	assign crc_nex4[0] = fd4;
	assign crc_nex4[1] = crc_nex3[0];
	assign crc_nex4[2] = crc_nex3[1];
	assign crc_nex4[3] = crc_nex3[2] ^ fd4;
	assign crc_nex4[4] = crc_nex3[3];

	//第6次
	wire [4:0] crc_nex5;
	wire fd5;
	assign fd5 = crc_nex4[4] ^ data[2];
	assign crc_nex5[0] = fd5;
	assign crc_nex5[1] = crc_nex4[0];
	assign crc_nex5[2] = crc_nex4[1];
	assign crc_nex5[3] = crc_nex4[2] ^ fd5;
	assign crc_nex5[4] = crc_nex4[3];

	//第7次
	wire [4:0] crc_nex6;
	wire fd6;
	assign fd6 = crc_nex5[4] ^ data[1];
	assign crc_nex6[0] = fd6;
	assign crc_nex6[1] = crc_nex5[0];
	assign crc_nex6[2] = crc_nex5[1];
	assign crc_nex6[3] = crc_nex5[2] ^ fd6;
	assign crc_nex6[4] = crc_nex5[3];

	//第8次
	wire [4:0] crc_nex7;
	wire fd7;
	assign fd7 = crc_nex6[4] ^ data[0];
	assign crc_nex7[0] = fd7;
	assign crc_nex7[1] = crc_nex6[0];
	assign crc_nex7[2] = crc_nex6[1];
	assign crc_nex7[3] = crc_nex6[2] ^ fd7;
	assign crc_nex7[4] = crc_nex6[3];

	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			crc <= 5'h09;
		else if (en)
			crc <= crc_nex7;
		else
			crc <= 5'h09;	
endmodule
