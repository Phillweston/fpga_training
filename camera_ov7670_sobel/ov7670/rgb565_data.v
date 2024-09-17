module rgb565_data(pi_clk, pi_rst_n, pi_flag_done, pi_vs, pi_hs, pi_data,
	po_rgb_data, po_clk, po_wrreq);
	
	input pi_clk;
	input pi_rst_n;
	input pi_flag_done;
	
	input pi_vs;
	input pi_hs;
	input [7:0] pi_data;
	
	output reg [15:0] po_rgb_data;
	output  po_clk;
	output reg po_wrreq;
	
	assign po_clk = ~pi_clk;
	
	reg [2:0] cmos_vs;
	
	always @ (posedge pi_clk)
		if(!pi_rst_n)
			begin
				cmos_vs <= 3'b111;
			end
		else
			begin
				cmos_vs[0] <= pi_vs;
				cmos_vs[1] <= cmos_vs[0];
				cmos_vs[2] <= cmos_vs[1];
			end
	
	wire flag;
	
	assign flag = pi_flag_done && (~cmos_vs[2] && cmos_vs[1]);
	
	reg [3:0] state;
	reg [7:0] temp;
	
	reg [9:0] x, y;

	always @ (posedge pi_clk)
		if(!pi_rst_n)
			begin
				state <= 0;
				temp <= 0;
				po_wrreq <= 0;
				po_rgb_data <= 0;
				y <= 0;
			end
		else
			begin
				case (state)	
					0	:	if(flag)
								state <= 1;
							else
								state <= 0;
					
					1	:	if(pi_hs)
								begin
									temp <= pi_data;
									state <= 2;
									po_wrreq <= 0;
								end
							else
								begin
									state <= 1;
									po_wrreq <= 0;
									y <= 0;
								end
					
					2	: 	if(pi_hs)
								begin
									po_rgb_data <= {temp,pi_data};
									po_wrreq <= 1;
									state <= 1;
									y <= y + 10'b1;
								end
							else
								begin
									state <= 2;
								end
					endcase
			end	

endmodule