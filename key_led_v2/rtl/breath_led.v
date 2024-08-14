module breath_led(
	input				sys_clk,
	input				sys_rst_n,
	
	output              led
);

	reg	[6 : 0]	cnt_100;
	reg	[9 : 0]	cnt_2us;
	reg	[9 : 0]	cnt_2ms;
	
	parameter	T100 = 100;
	parameter	T2us = 1000;
	parameter	T2ms = 1000;

	// cnt100 counter (20ns, 0~99)
	always @ (posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n)
			cnt_100 <= 7'b0;
		else if (cnt_100 < T100 - 1'b1)
			cnt_100 <= cnt_100 + 1'b1;
		else
			cnt_100 <= 7'b0;
	end
	
	// cnt_2us counter (2us, 0~999)
	always @ (posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n)
			cnt_2us <= 10'b0;
		else if (cnt_100 == T100 - 1'b1) begin
			if (cnt_2us < T2us - 1'b1)
				cnt_2us <= cnt_2us + 1'b1;
			else
				cnt_2us <= 10'b0;
        end else
			cnt_2us <= cnt_2us;
	end
	
	// cnt_2ms counter (2ms, 0~999)
	reg				en;			//2s使能(0:2s	1:2s)
	
	always @ (posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
			cnt_2ms <= 10'b0;
			en <= 1'b0;
        end else if (cnt_100 == T100 - 1'b1 && cnt_2us == T2us - 1'b1) begin
			if (cnt_2ms < T2ms - 1'b1)
				cnt_2ms <= cnt_2ms + 1'b1;
			else begin
				cnt_2ms <= 10'b0;
				en <= ~en;
			end
		end else
			cnt_2ms <= cnt_2ms;
	end
	
	// Generate PWM
	wire	pwm;
	
	assign	pwm = (cnt_2ms > cnt_2us) ? 1'b1 : 1'b0;
	
	// Assign breathe LED, 2s time base
	assign	led = (en == 1'b0) ? ~pwm : pwm;
    
endmodule