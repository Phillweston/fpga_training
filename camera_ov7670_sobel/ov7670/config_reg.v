module config_reg (pi_clk, pi_rst_n, pi_deay, pi_reg_data, po_sccb_clk,
	po_reg_id, pio_sccb_data, po_flag_done);
	
	input pi_clk;
	input pi_rst_n;
	input pi_deay;
	input [15:0] pi_reg_data;
	
	output reg  po_sccb_clk;
	output reg [7:0] po_reg_id;
	output reg po_flag_done;
	inout pio_sccb_data;
	
	reg flag, sda_buff;
	
	assign pio_sccb_data = flag ? sda_buff : 1'bz;
	
	localparam  wr = 8'h42;
	localparam  T200ms = 30_000;
	
	reg [7:0] temp;
	reg [3:0] cnt;
	reg [4:0] state;
	reg [15:0] count;
	
	always @ (negedge pi_clk)
		if(!pi_rst_n)
			begin
				po_sccb_clk <= 1'b1;
			end
		else
			begin
				if((state > 0) && (state < 8))
					po_sccb_clk <= ~po_sccb_clk;
				else
					po_sccb_clk <= 1'b1;
			end
	
	always @ (posedge pi_clk)
		if(!pi_rst_n)
			begin
				state <= 0;
				flag <= 1;
				sda_buff <= 1;
				temp <= 0;
				cnt <= 0;
				po_reg_id <= 0;
				count <= 0;
				po_flag_done <= 0;
			end
		else
			begin
				case (state)
					0	:	if(pi_deay && po_sccb_clk)
								begin
									flag <= 1;
									state <= 1;
									sda_buff <= 0;
									temp <= wr;
								end
							else
								begin
									state <= 0;
									flag <= 1;
									sda_buff <= 1;
								end
					
					1	:	if(!po_sccb_clk && cnt < 8)
								begin
									cnt <= cnt + 1'b1;
									sda_buff <= temp[7];
									temp <= {temp[6:0],1'b0};
								end
							else
								begin
									if(cnt == 8)
										begin
											cnt <= 0;
											state <= 2;
										end
									else
										state <= 1;
								end
					
					2	:	if(!po_sccb_clk)
								begin
									flag <= 0;
									state <= 3;
									temp <= pi_reg_data[15:8];
								end
							else
								state <= 2;
					
					3	:	if(!po_sccb_clk && cnt < 8)
								begin
									flag <= 1;
									cnt <= cnt + 1'b1;
									sda_buff <= temp[7];
									temp <= {temp[6:0],1'b0};
								end
							else
								begin
									if(cnt == 8)
										begin
											cnt <= 0;
											state <= 4;
										end
									else
										state <= 3;
								end
					
					4	:	if(!po_sccb_clk)
								begin
									flag <= 0;
									state <= 5;
									temp <= pi_reg_data[7:0];
								end
							else
								state <= 4;
					
					5	:	if(!po_sccb_clk && cnt < 8)
								begin
									flag <= 1;
									cnt <= cnt + 1'b1;
									sda_buff <= temp[7];
									temp <= {temp[6:0],1'b0};
								end
							else
								begin
									if(cnt == 8)
										begin
											cnt <= 0;
											state <= 6;
										end
									else
										state <= 5;
								end
					
					6	:	if(!po_sccb_clk)
								begin
									flag <= 0;
									state <= 7;
								end
							else
								state <= 6;
					
					7	:	if(!po_sccb_clk)
								begin
									state <= 9;
									flag <= 1;
									sda_buff <= 0;
								end
							else
								state <= 7;
					
					9	:	if(po_sccb_clk)  
								begin
									sda_buff <= 1;
									state <= 10;
								end
							else
								state <= 9;
					
					10	:	if(!cnt[3])
								cnt <= cnt + 1'd1;
							else
								begin
									cnt <= 0;
									state <= 11;
								end
					
					11	:	if(po_reg_id == 165)
								begin
									state <= 12;
								end
							else
								begin
									state <= 0;
									po_reg_id <= po_reg_id + 1'd1;
								end
					
					12 :	if(count < T200ms - 1 )
									count <= count + 1'd1;
							else
								begin
									count <= count;
									po_flag_done <= 1;
								end
								
					default : state <= 0;
				  endcase
			end	

endmodule 