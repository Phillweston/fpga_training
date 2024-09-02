module beep_driver(
	input						sys_clk,
	input						sys_rst_n,
	input						key_flag,
	
	output					beep								//无源蜂鸣器(震荡频率:方波(2.5KHZ))
);

	reg			[31:0]	cnt_max;							//0.1s(蜂鸣器鸣叫时间长短)
	reg			[31:0]	cnt_freq;						//2.5KHZ(方波频率)
	reg						en;								//驱动蜂鸣器发声使能
	
	parameter				MAX = 50_000_000 / 10;		//0.1s
	parameter				T   = 50_000_000 / 2500;	//2.5KHZ
	
	//产生0.1s
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt_max <= 32'd0;
		else	if(key_flag == 1'b1)
			cnt_max <= 32'd0;
		else	if(cnt_max < MAX - 1'd1)
			cnt_max <= cnt_max + 1'd1;
		else
			cnt_max <= MAX - 1'd1;
	end
	
	//产生2.5KHZ
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			cnt_freq <= 32'd0;
			en <= 1'b0;
		end
		else	if(cnt_freq < T / 2 - 1'd1)	begin
			cnt_freq <= cnt_freq + 1'd1;
			en <= en;
		end
		else	begin
			cnt_freq <= 32'd0;
			en <= ~en;
		end
	end
	
	//使其BEEP鸣叫
	assign	beep = (cnt_max < MAX - 1'd1) ? en : 1'b1;

endmodule
