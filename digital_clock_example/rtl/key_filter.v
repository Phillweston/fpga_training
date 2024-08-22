//按键消抖(按键消抖后的输出动作):软件消抖(延时10ms)
module key_filter(
	input						sys_clk,
	input						sys_rst_n,
	input						key_in,											//输入独立按键
	
	output		reg				key_out											//输出消抖后按键的动作
);

	reg			[1:0]		current_state;
	reg			[1:0]		next_state;
	reg			[31:0]		cnt;
	
	parameter				T10ms = 50_000_000 / 100;					//10ms
	
	parameter				s0 = 2'b00;										//按键按下
	parameter				s1 = 2'b01;										//按下时抖动处理
	parameter				s2 = 2'b10;										//按键抬起
	parameter				s3 = 2'b11;										//抬起时抖动处理
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin	:	FSM_3S_1_CN_Mealy
		if(sys_rst_n == 1'b0)
			current_state <= s0;
		else
			current_state <= next_state;
	end
	
	always @ (*)	begin	:	FSM_3S_2_ON_Mealy		
		next_state = 2'bx;
		case(current_state)
			s0:	begin
				if(key_in == 1'b0)
					next_state = s1;
				else
					next_state = s0;
			end
									
			s1:	begin
				if(key_in == 1'b0) begin
					if(cnt < T10ms - 1'd1)
						next_state = s1;
					else
						next_state = s2;
				end
				else
					next_state = s1;
			end
									
			s2: begin
				if(key_in == 1'b1)
					next_state = s3;
				else
					next_state = s2;
			end
									
			s3:	begin
				if(key_in == 1'b1) begin
					if(cnt < T10ms - 1'd1)
						next_state = s3;
					else
						next_state = s0;
				end
				else
					next_state = s3;
			end
									
			default: next_state = s0;
		endcase
	end
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin	:	FSM_3S_3_CN_Mealy
		if(sys_rst_n == 1'b0) begin
			cnt <= 32'd0;
			key_out <= 1'b1;
		end
		else
			case(current_state)
				s1:	begin
					if(cnt < T10ms - 1'd1) begin
						cnt <= cnt + 1'd1;
						key_out <= 1'b1;
					end
					else begin
						cnt <= 32'd0;
						key_out <= 1'b0;
					end
				end
								
				s3:	begin
					if(cnt < T10ms - 1'd1) begin
						cnt <= cnt + 1'd1;
						key_out <= 1'b0;
					end
					else begin
						cnt <= 32'd0;
						key_out <= 1'b1;
					end
				end
								
				default: key_out <= key_out;
			endcase
	end

endmodule
