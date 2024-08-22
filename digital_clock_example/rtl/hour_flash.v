module hour_flash(
	input							sys_clk,
	input							sys_rst_n,
	input							hour_en,
	input				[7:0]		bcd_hour,
	
	output		reg		[7:0]		hour_data
);

	parameter		T = 50_000_000;
	reg				[31:0]		cnt;
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
			hour_data <= 8'd0;
		else if(hour_en == 1'd1) begin
			if(T1s_half == 1'd1)
				hour_data <= bcd_hour;
			else
				hour_data <= 8'hFF;
		end else
			hour_data <= bcd_hour;
	end


endmodule
