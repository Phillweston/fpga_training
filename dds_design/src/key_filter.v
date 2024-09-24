module key_filter (
	input	wire				clk,
	input	wire				rst_n,
	input	wire				ikey,
	output	reg					okey
);

	parameter	MASK_TIME	=		500_00;
	// parameter	MASK_TIME	=		25;
	
	localparam	OFF			=		4'b0001;
	localparam	ON_SHAKE	=		4'b0010;
	localparam	ON			=		4'b0100;
	localparam	OFF_SHAKE	=		4'b1000;

	reg				[3:0]		c_state;
	reg				[3:0]		n_state;
	reg				[17:0]		cnt;
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			c_state <= OFF;
		else
			c_state <= n_state;
	end
	
	always @ (c_state, cnt, ikey) begin
		case (c_state)
			OFF			:	if (ikey)
								n_state = OFF;
							else
								n_state = ON_SHAKE;
								
			ON_SHAKE	:	if (ikey)
								n_state = OFF;
							else
								if (cnt == MASK_TIME - 1)
									n_state = ON;
								else
									n_state = ON_SHAKE;
									
			ON			:	if (ikey)
								n_state = OFF_SHAKE;
							else
								n_state = ON;
								
			OFF_SHAKE	:	if (~ikey)
								n_state = ON;
							else
								if (cnt == MASK_TIME - 1)
									n_state = OFF;
								else
									n_state = OFF_SHAKE;
	
			default		:			n_state = OFF;
		endcase
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			cnt <= 0;
		else
			case (c_state)
				OFF			:	cnt <= 0;
				ON_SHAKE	:	if (ikey)
									cnt <= 0;
								else
									cnt <= cnt + 1'b1;
									
				ON			:	cnt <= 0;
				OFF_SHAKE	:	if (~ikey)
									cnt <= 0;
								else
									cnt <= cnt + 1'b1;
				default		:		cnt <= 0;
			endcase
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			okey <= 1;
		else
			case (c_state)
				OFF			:	okey <= 1;
				ON_SHAKE	:	okey <= 1;
				ON			:	okey <= 0;
				OFF_SHAKE	:	okey <= 0;
				default		:	okey <= 1;
			endcase
	end

endmodule 