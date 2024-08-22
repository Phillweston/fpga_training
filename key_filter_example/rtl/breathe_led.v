//使用ZX-1板卡上的一个LED实现呼吸灯功能
//呼吸整个周期时间为4s，呼2s，吸2s
module breathe_led(
	input						sys_clk,					//系统时钟:50MHZ
	input						sys_rst_n,				//系统复位:低有效
	
	output					LED						//LED:低电平点亮
);

	reg			[6:0]		cnt_100;					//cnt_100计数器:0~99(记录20ns个数)
	reg			[9:0]		cnt_2us;					//cnt_2us计数器:0~999(记录2us个数)
	reg			[9:0]		cnt_2ms;					//cnt_2ms计数器:0~999(记录2ms个数)
	
	parameter				T100	= 100;			//定参
	parameter				T2us	= 1000;			//定参
	parameter				T2ms	= 1000;			//定参
	
	//cnt_100计数器:2us
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt_100 <= 7'd0;
		else	if(cnt_100 < T100 - 1'd1)
			cnt_100 <= cnt_100 + 1'd1;
		else
			cnt_100 <= 7'd0;
	end
	
	//cnt_2us计数器:2ms
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt_2us <= 10'd0;
		else	if(cnt_100 == T100 - 1'd1)	begin
			if(cnt_2us < T2us - 1'd1)
				cnt_2us <= cnt_2us + 1'd1;
			else
				cnt_2us <= 10'd0;
		end
		else	
			cnt_2us <= cnt_2us;
	end
	
	//cnt_2ms计数器:2s
	reg				en;				//2s使能(0:2s	1:2s)
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			cnt_2ms <= 10'd0;
			en <= 1'b0;
		end
		else	if(cnt_100 == T100 - 1'd1 && cnt_2us == T2us - 1'd1)	begin
			if(cnt_2ms < T2ms - 1'd1)
				cnt_2ms <= cnt_2ms + 1'd1;
			else	begin
				cnt_2ms <= 10'd0;
				en <= ~en;
			end
		end
		else
			cnt_2ms <= cnt_2ms;
	end
	
	//产生PWM
	wire				pwm;
	
	assign	pwm = (cnt_2ms > cnt_2us) ? 1'b1 : 1'b0;	

	//呼吸灯:周期4s
	assign	LED = (en == 1'b0) ? ~pwm : pwm;

endmodule
