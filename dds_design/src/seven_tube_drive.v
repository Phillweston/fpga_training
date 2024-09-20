module seven_tube_drive (

	input	wire				clk,
	input	wire				rst_n,
	
	input	wire	[23:0]		idata,
	
	output	reg		[7:0]		seven_tube_seg,
	output	reg		[2:0]		seven_tube_sel
);

	localparam		T_1ms	=	50_000;
	//localparam		T_1ms	=	5;	// for test

	localparam		S0		=	6'b000_001;
	localparam		S1		=	6'b000_010;
	localparam		S2		=	6'b000_100;
	localparam		S3		=	6'b001_000;
	localparam		S4		=	6'b010_000;
	localparam		S5		=	6'b100_000;
	
	
	reg				[5:0]		c_state;
	reg				[5:0]		n_state;
	reg				[15:0]		cnt;
	reg				[3:0]		temp;
	
	reg				[23:0]		show_data;
	
	always @ (posedge clk) show_data <= idata; 
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			cnt <= 0;
		else
			if (cnt < T_1ms - 1)
				cnt <= cnt + 1'b1;
			else
				cnt <= 0;
	end

	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			c_state <= S0;
		else
			c_state <= n_state;
	end

	always @ (c_state, cnt) begin
		case (c_state)
			S0		:	if (cnt == T_1ms - 1)
							n_state = S1;
						else
							n_state = S0;
			S1		:	if (cnt == T_1ms - 1)
							n_state = S2;
						else
							n_state = S1;
			S2		:	if (cnt == T_1ms - 1)
							n_state = S3;
						else
							n_state = S2;
			S3		:	if (cnt == T_1ms - 1)
							n_state = S4;
						else
							n_state = S3;
			S4		:	if (cnt == T_1ms - 1)
							n_state = S5;
						else
							n_state = S4;
			S5		:	if (cnt == T_1ms - 1)
							n_state = S0;
						else
							n_state = S5;
			default	:		n_state = S0;
			
		endcase
	end

	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			seven_tube_sel <= 3'b000;
		else
			case (c_state)
				S0		:	seven_tube_sel <= 3'b000;
				S1		:	seven_tube_sel <= 3'b001;
				S2		:	seven_tube_sel <= 3'b010;
				S3		:	seven_tube_sel <= 3'b011;
				S4		:	seven_tube_sel <= 3'b100;
				S5		:	seven_tube_sel <= 3'b101;
				default	:	seven_tube_sel <= 3'b000;
			endcase
	end
	
	always @ (c_state, show_data) begin
		case (c_state)
			S0		:	temp = show_data[23:20];
			S1		:	temp = show_data[19:16];
			S2		:	temp = show_data[15:12];
			S3		:	temp = show_data[11:8];
			S4		:	temp = show_data[7:4];
			S5		:	temp = show_data[3:0];
			default	:	temp = 4'hf;
		endcase
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			seven_tube_seg <= 8'hff;
		else
			case (temp)
				0		:	seven_tube_seg <= 8'b1100_0000;
				1		:	seven_tube_seg <= 8'b1111_1001;
				2		:	seven_tube_seg <= 8'b1010_0100;
				3		:	seven_tube_seg <= 8'b1011_0000;
				4		:	seven_tube_seg <= 8'b1001_1001;
				5		:	seven_tube_seg <= 8'b1001_0010;
				6		:	seven_tube_seg <= 8'b1000_0010;
				7		:	seven_tube_seg <= 8'b1111_1000;
				8		:	seven_tube_seg <= 8'b1000_0000;
				9		:	seven_tube_seg <= 8'b1001_0000;
				10		:	seven_tube_seg <= 8'b1000_1000;
				11		:	seven_tube_seg <= 8'b1000_0011;
				12		:	seven_tube_seg <= 8'b1100_0110;
				13		:	seven_tube_seg <= 8'b1010_0001;
				14		:	seven_tube_seg <= 8'b1000_0110;
				15		:	seven_tube_seg <= 8'b1000_1110;
				default	:	seven_tube_seg <= 8'hff;
			endcase
	end
	
endmodule 
