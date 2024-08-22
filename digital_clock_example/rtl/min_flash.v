module min_flash(
	input							sys_clk,
	input							sys_rst_n,
	input							min_en,
	input				[7:0]		bcd_min,
	
	output		reg		[7:0]		min_data
);

	parameter		T = 50_000_000;
	reg				[23:0]	cnt;
	reg							T1s_half;

	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(!sys_rst_n) begin
			cnt <= 24'd0;
			T1s_half <= 1'd0;
		end
		else if(cnt < T / 2 - 1'd1)
			cnt <= cnt + 1'd1;
		else begin
			cnt <= 1'd0;
			T1s_half <= ~T1s_half;
		end
	end
		
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(!sys_rst_n)
			min_data <= 8'd0;
		else if(min_en == 1'd1) begin
			if(T1s_half == 1'd1)
				min_data <= bcd_min;
			else
				min_data <= 8'hFF;
		end else
			min_data <= bcd_min;
	end

endmodule
