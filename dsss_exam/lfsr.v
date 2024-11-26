`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:Engi-kou
//
// Create Date:   14:34:34 09/26/2015
// Design Name:/lfsr.v
// Module Name:   
// Project Name: 
// Target Device:
// Tool versions:
// Description:利用线性移位寄存器产生均匀分布的随机数
//
// Verilog Test Fixture created by ISE for module: seq_top
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module lfsr
(
	input clk,
	input rst_n,
	output reg [27:0] m_array1,
	output reg [27:0] m_array2,
	output reg [27:0] m_array3,
	output reg [27:0] m_array4,
	output reg [27:0] m_array5,
	output reg [27:0] m_array6,
	output reg [27:0] m_array7,
	output reg [27:0] m_array8,
	output reg [27:0] m_array9,
	output reg [27:0] m_arraya,
	output reg [27:0] m_arrayb,
	output reg [27:0] m_arrayc
);

	//-------------定义temp----------------------------------------------
	wire [1:0] temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18;
	wire [1:0] temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28;
	wire [1:0] temp31,temp32,temp33,temp34,temp35,temp36,temp37,temp38;
	wire [1:0] temp41,temp42,temp43,temp44,temp45,temp46,temp47,temp48;
	wire [1:0] temp51,temp52,temp53,temp54,temp55,temp56,temp57,temp58;
	wire [1:0] temp61,temp62,temp63,temp64,temp65,temp66,temp67,temp68;
	wire [1:0] temp71,temp72,temp73,temp74,temp75,temp76,temp77,temp78;
	wire [1:0] temp81,temp82,temp83,temp84,temp85,temp86,temp87,temp88;
	wire [1:0] temp91,temp92,temp93,temp94,temp95,temp96,temp97,temp98;
	wire [1:0] tempa1,tempa2,tempa3,tempa4,tempa5,tempa6,tempa7,tempa8;
	wire [1:0] tempb1,tempb2,tempb3,tempb4,tempb5,tempb6,tempb7,tempb8;
	wire [1:0] tempc1,tempc2,tempc3,tempc4,tempc5,tempc6,tempc7,tempc8;

	//-------------定义shift_reg----------------------------------------------
	reg [27:0] shift_reg1,shift_reg2,shift_reg3,shift_reg4,shift_reg5,shift_reg6,shift_reg7,shift_reg8,shift_reg9,shift_rega,shift_regb,shift_regc;

	//-------------加运算----------------------------------------------
	assign 	temp11 = shift_reg1[19] + shift_reg1[0];
	assign	temp12 = shift_reg1[20] + shift_reg1[1];
	assign	temp13 = shift_reg1[21] + shift_reg1[2];
	assign	temp14 = shift_reg1[22] + shift_reg1[3];
	assign	temp15 = shift_reg1[23] + shift_reg1[4];
	assign	temp16 = shift_reg1[24] + shift_reg1[5];
	assign	temp17 = shift_reg1[25] + shift_reg1[6];
	assign	temp18 = shift_reg1[26] + shift_reg1[7];

	assign 	temp21 = shift_reg2[19] + shift_reg2[0];
	assign	temp22 = shift_reg2[20] + shift_reg2[1];
	assign	temp23 = shift_reg2[21] + shift_reg2[2];
	assign	temp24 = shift_reg2[22] + shift_reg2[3];
	assign	temp25 = shift_reg2[23] + shift_reg2[4];
	assign	temp26 = shift_reg2[24] + shift_reg2[5];
	assign	temp27 = shift_reg2[25] + shift_reg2[6];
	assign	temp28 = shift_reg2[26] + shift_reg2[7];

	assign 	temp31 = shift_reg3[19] + shift_reg3[0];
	assign	temp32 = shift_reg3[20] + shift_reg3[1];
	assign	temp33 = shift_reg3[21] + shift_reg3[2];
	assign	temp34 = shift_reg3[22] + shift_reg3[3];
	assign	temp35 = shift_reg3[23] + shift_reg3[4];
	assign	temp36 = shift_reg3[24] + shift_reg3[5];
	assign	temp37 = shift_reg3[25] + shift_reg3[6];
	assign	temp38 = shift_reg3[26] + shift_reg3[7];

	assign 	temp41 = shift_reg4[19] + shift_reg4[0];
	assign	temp42 = shift_reg4[20] + shift_reg4[1];
	assign	temp43 = shift_reg4[21] + shift_reg4[2];
	assign	temp44 = shift_reg4[22] + shift_reg4[3];
	assign	temp45 = shift_reg4[23] + shift_reg4[4];
	assign	temp46 = shift_reg4[24] + shift_reg4[5];
	assign	temp47 = shift_reg4[25] + shift_reg4[6];
	assign	temp48 = shift_reg4[26] + shift_reg4[7];

	assign 	temp51 = shift_reg5[19] + shift_reg5[0];
	assign	temp52 = shift_reg5[20] + shift_reg5[1];
	assign	temp53 = shift_reg5[21] + shift_reg5[2];
	assign	temp54 = shift_reg5[22] + shift_reg5[3];
	assign	temp55 = shift_reg5[23] + shift_reg5[4];
	assign	temp56 = shift_reg5[24] + shift_reg5[5];
	assign	temp57 = shift_reg5[25] + shift_reg5[6];
	assign	temp58 = shift_reg5[26] + shift_reg5[7];

	assign 	temp61 = shift_reg6[19] + shift_reg6[0];
	assign	temp62 = shift_reg6[20] + shift_reg6[1];
	assign	temp63 = shift_reg6[21] + shift_reg6[2];
	assign	temp64 = shift_reg6[22] + shift_reg6[3];
	assign	temp65 = shift_reg6[23] + shift_reg6[4];
	assign	temp66 = shift_reg6[24] + shift_reg6[5];
	assign	temp67 = shift_reg6[25] + shift_reg6[6];
	assign	temp68 = shift_reg6[26] + shift_reg6[7];

	assign 	temp71 = shift_reg7[19] + shift_reg7[0];
	assign	temp72 = shift_reg7[20] + shift_reg7[1];
	assign	temp73 = shift_reg7[21] + shift_reg7[2];
	assign	temp74 = shift_reg7[22] + shift_reg7[3];
	assign	temp75 = shift_reg7[23] + shift_reg7[4];
	assign	temp76 = shift_reg7[24] + shift_reg7[5];
	assign	temp77 = shift_reg7[25] + shift_reg7[6];
	assign	temp78 = shift_reg7[26] + shift_reg7[7];

	assign 	temp81 = shift_reg8[19] + shift_reg8[0];
	assign	temp82 = shift_reg8[20] + shift_reg8[1];
	assign	temp83 = shift_reg8[21] + shift_reg8[2];
	assign	temp84 = shift_reg8[22] + shift_reg8[3];
	assign	temp85 = shift_reg8[23] + shift_reg8[4];
	assign	temp86 = shift_reg8[24] + shift_reg8[5];
	assign	temp87 = shift_reg8[25] + shift_reg8[6];
	assign	temp88 = shift_reg8[26] + shift_reg8[7];

	assign 	temp91 = shift_reg9[19] + shift_reg9[0];
	assign	temp92 = shift_reg9[20] + shift_reg9[1];
	assign	temp93 = shift_reg9[21] + shift_reg9[2];
	assign	temp94 = shift_reg9[22] + shift_reg9[3];
	assign	temp95 = shift_reg9[23] + shift_reg9[4];
	assign	temp96 = shift_reg9[24] + shift_reg9[5];
	assign	temp97 = shift_reg9[25] + shift_reg9[6];
	assign	temp98 = shift_reg9[26] + shift_reg9[7];

	assign 	tempa1 = shift_rega[19] + shift_rega[0];
	assign	tempa2 = shift_rega[20] + shift_rega[1];
	assign	tempa3 = shift_rega[21] + shift_rega[2];
	assign	tempa4 = shift_rega[22] + shift_rega[3];
	assign	tempa5 = shift_rega[23] + shift_rega[4];
	assign	tempa6 = shift_rega[24] + shift_rega[5];
	assign	tempa7 = shift_rega[25] + shift_rega[6];
	assign	tempa8 = shift_rega[26] + shift_rega[7];

	assign 	tempb1 = shift_regb[19] + shift_regb[0];
	assign	tempb2 = shift_regb[20] + shift_regb[1];
	assign	tempb3 = shift_regb[21] + shift_regb[2];
	assign	tempb4 = shift_regb[22] + shift_regb[3];
	assign	tempb5 = shift_regb[23] + shift_regb[4];
	assign	tempb6 = shift_regb[24] + shift_regb[5];
	assign	tempb7 = shift_regb[25] + shift_regb[6];
	assign	tempb8 = shift_regb[26] + shift_regb[7];

	assign 	tempc1 = shift_regc[19] + shift_regc[0];
	assign	tempc2 = shift_regc[20] + shift_regc[1];
	assign	tempc3 = shift_regc[21] + shift_regc[2];
	assign	tempc4 = shift_regc[22] + shift_regc[3];
	assign	tempc5 = shift_regc[23] + shift_regc[4];
	assign	tempc6 = shift_regc[24] + shift_regc[5];
	assign	tempc7 = shift_regc[25] + shift_regc[6];
	assign	tempc8 = shift_regc[26] + shift_regc[7];

	//-------------均匀分布随机数运算----------------------------------------------
	always @(posedge clk or negedge rst_n) begin		//1
		if (~rst_n)
			shift_reg1 <= 28'b1011011011010100011101110101;
		else begin
			shift_reg1 <= {temp18[0], temp17[0], temp16[0], temp15[0], temp14[0], temp13[0], temp12[0], temp11[0], shift_reg1[27:8]};
			m_array1 <= shift_reg1;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//2
		if (~rst_n)
			shift_reg2 <= 28'b0100110110101010101011111110;
		else begin
			shift_reg2 <= {temp28[0], temp27[0], temp26[0], temp25[0], temp24[0], temp23[0], temp22[0], temp21[0], shift_reg2[27:8]};
			m_array2 <= shift_reg2;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//3
		if (~rst_n)
			shift_reg3 <= 28'b1011001101010111000111111000;
		else begin
			shift_reg3 <= {temp38[0], temp37[0], temp36[0], temp35[0], temp34[0], temp33[0], temp32[0], temp31[0], shift_reg3[27:8]};
			m_array3 <= shift_reg3;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//4
		if (~rst_n)
			shift_reg4 <= 28'b1110001010111100011011101000;
		else begin
			shift_reg4 <= {temp48[0], temp47[0], temp46[0], temp45[0], temp44[0], temp43[0], temp42[0], temp41[0], shift_reg4[27:8]};
			m_array4 <= shift_reg4;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//5
		if (~rst_n)
			shift_reg5 <= 28'b0111101110101011100011100101;
		else begin
			shift_reg5 <= {temp58[0], temp57[0], temp56[0], temp55[0], temp54[0], temp53[0], temp52[0], temp51[0], shift_reg5[27:8]};
			m_array5 <= shift_reg5;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//6
		if (~rst_n)
			shift_reg6 <= 28'b1100110010100101100000100001;
		else begin
			shift_reg6 <= {temp68[0], temp67[0], temp66[0], temp65[0], temp64[0], temp63[0], temp62[0], temp61[0], shift_reg6[27:8]};
			m_array6 <= shift_reg6;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//7
		if (~rst_n)
			shift_reg7 <= 28'b0000000100111110100101011100;
		else begin
			shift_reg7 <= {temp78[0], temp77[0], temp76[0], temp75[0], temp74[0], temp73[0], temp72[0], temp71[0], shift_reg7[27:8]};
			m_array7 <= shift_reg7;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//8
		if (~rst_n)
			shift_reg8 <= 28'b0101011100001011000011011101;
		else begin
			shift_reg8 <= {temp88[0], temp87[0], temp86[0], temp85[0], temp84[0], temp83[0], temp82[0], temp81[0], shift_reg8[27:8]};
			m_array8 <= shift_reg8;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//9
		if (~rst_n)
			shift_reg9 <= 28'b1010101110101001100010111000;
		else begin
			shift_reg9 <= {temp98[0], temp97[0], temp96[0], temp95[0], temp94[0], temp93[0], temp92[0], temp91[0], shift_reg9[27:8]};
			m_array9 <= shift_reg9;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//10
		if (~rst_n)
			shift_rega <= 28'b1000110010110010110100010101;
		else begin
			shift_rega <= {tempa8[0], tempa7[0], tempa6[0], tempa5[0], tempa4[0], tempa3[0], tempa2[0], tempa1[0], shift_rega[27:8]};
			m_arraya <= shift_rega;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//11
		if (~rst_n)
			shift_regb <= 28'b0000100101101011110101011100;
		else begin
			shift_regb <= {tempb8[0], tempb7[0], tempb6[0], tempb5[0], tempb4[0], tempb3[0], tempb2[0], tempb1[0], shift_regb[27:8]};
			m_arrayb <= shift_regb;
		end
	end

	always @(posedge clk or negedge rst_n) begin		//12
		if (~rst_n)
			shift_regc <= 28'b1010100111011000111011100010;
		else begin
			shift_regc <= {tempc8[0], tempc7[0], tempc6[0], tempc5[0], tempc4[0], tempc3[0], tempc2[0], tempc1[0], shift_regc[27:8]};
			m_arrayc <= shift_regc;
		end
	end

endmodule