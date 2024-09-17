module freq_delay(pi_clk, pi_rst_n, po_clk_100k, po_rst_n_deay);

	input pi_clk;
	input pi_rst_n;
	
	output reg po_clk_100k;
	output reg po_rst_n_deay;
	
	reg [20:0] count;
	always @ (posedge pi_clk)
		begin
			if(!pi_rst_n)
				begin
					count <= 1'b0;
					po_clk_100k <= 1'b1;
				end
			else if(count == (100_000_000 /100_000 / 2 - 1))
					begin
						count <= 1'b0;
						po_clk_100k <= ~po_clk_100k;
					end
			else
				count <= count + 1'b1;	
		end

	reg [20:0] cnt;
	always @ (posedge po_clk_100k)
		if(!pi_rst_n)
			begin
				cnt <= 1'b0;
				po_rst_n_deay <= 1'b0;
			end
		else if(cnt == 100 - 1'b1)
			begin
				po_rst_n_deay <= 1'b1;
				cnt <= cnt;
			end
		else
			cnt <= cnt + 1'b1;

endmodule