module arbiteri
(
	//系统相关
	input				clk,	//系统时钟
	input				rst_n,	//系统复位
	//总线请求
	input [1:0]			req,	/*req[1:0]
								2’b01:表示sof_cfg电路模块请求总线
								2’b10:表示img_process电路模块请求总线
								2’b11:表示sof_cfg和img_process同时请求总线
								2’b00:没有任何总线请求*/
	output reg [1:0]	gnt	/*  gnt[1:0]
								2’b01：当前时刻允许sof_cfg电路模块请求总线
								2’b10：当前时刻允许img_process电路模块请求总线
								2’b00: 当前时刻不允许请求总线
								2’b11:这种不允许存在*/
);
	localparam SLOT0 = 1'b0,
			   SLOT1 = 1'b1;
	reg	state;

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			state <= SLOT0;
		else case (state)
			SLOT0:
				if (req == 2'b10)
					state <= SLOT1;
			SLOT1:
				if (req == 2'b01)
					state <= SLOT0;
			default:
				state <= SLOT0;
		endcase

	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			gnt <= 2'b00;
		else case (state)
			SLOT0:
				case (req[1:0])
					2'b00: gnt <= 2'b00;
					2'b01: gnt <= 2'b01;
					2'b10: gnt <= 2'b10;
					2'b11: gnt <= 2'b01;
					default: gnt <= gnt;
				endcase
					
			SLOT1:
				case (req[1:0])
					2'b00: gnt <= 2'b00;
					2'b01: gnt <= 2'b01;
					2'b10: gnt <= 2'b10;
					2'b11: gnt <= 2'b10;
					default: gnt <= gnt;
				endcase
			default:
				gnt <= gnt;
		endcase
endmodule