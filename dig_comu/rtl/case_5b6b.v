module case_5b6b (
    // 系统相关
    input           clk,            // 编码器时钟
    input           rst_n,          // 系统复位
    // 编码数据输入
    input           valid_din,      // 当==1表示din[4:0]有效
    input   [4:0]   din,            // 被编码数据
    // 编码输出
    output  reg [9:4] dout,         // 编码数据
    output  reg     flag_dout,      // 当flag_dout==1表示dout有效
    // 编码极性
    input           rd              /* Rd
                                        0: 表示rd-
                                        1: 表示rd+ */
);

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			dout <= 6'd0;
		else if (valid_din)
			case (din[4:0])
				5'd0  : if (~rd) dout <= 6'b010111; else dout <= 6'b011000;
				5'd1  : if (~rd) dout <= 6'b011101; else dout <= 6'b100010;
				5'd2  : if (~rd) dout <= 6'b101101; else dout <= 6'b010010;
				5'd3  : dout <= 6'b110001;
				5'd4  : if (~rd) dout <= 6'b110101; else dout <= 6'b001010;
				5'd5  : dout <= 6'b101001;
				5'd6  : dout <= 6'b011001;
				5'd7  : if (~rd) dout <= 6'b111000; else dout <= 6'b000111;
				5'd8  : if (~rd) dout <= 6'b111001; else dout <= 6'b000110;
				5'd9  : dout <= 6'b100101;
				5'd10 : dout <= 6'b010101;
				5'd11 : dout <= 6'b110100;
				5'd12 : dout <= 6'b001101;
				5'd13 : dout <= 6'b101100;
				5'd14 : dout <= 6'b011100;
				5'd15 : if (~rd) dout <= 6'b010111; else dout <= 6'b101000;
				5'd16 : if (~rd) dout <= 6'b011011; else dout <= 6'b100100;
				5'd17 : dout <= 6'b100011;
				5'd18 : dout <= 6'b010011;
				5'd19 : dout <= 6'b110010;
				5'd20 : dout <= 6'b001011;
				5'd21 : dout <= 6'b101010;
				5'd22 : dout <= 6'b011010;
				5'd23 : if (~rd) dout <= 6'b111010; else dout <= 6'b000101;
				5'd24 : if (~rd) dout <= 6'b110011; else dout <= 6'b001100;
				5'd25 : dout <= 6'b100110;
				5'd26 : dout <= 6'b010110;
				5'd27 : if (~rd) dout <= 6'b110110; else dout <= 6'b001001;
				5'd28 : dout <= 6'b001110;
				5'd29 : if (~rd) dout <= 6'b101110; else dout <= 6'b010001;
				5'd30 : if (~rd) dout <= 6'b011110; else dout <= 6'b100001;
				5'd31 : if (~rd) dout <= 6'b101011; else dout <= 6'b010100;
				default: dout <= dout;
			endcase
	end

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			flag_dout <= 1'b0;
		else
			flag_dout <= valid_din;
	end

endmodule