module case_3b4b (
    // ϵͳ���
    input           clk,        // ������ʱ��
    input           rst_n,
    // ������������
    input           valid_din,  // ��==1��ʾdin[7:5]��Ч
    input   [7:5]   din,        // ����������
    // �������
    output  reg [3:0] dout,     // ��������
    // ���뼫��
    input           rd          /* Rd
                                    0: ��ʾrd-
                                    1: ��ʾrd+ */
);

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			dout <= 4'd0;
		else if (valid_din)
			case (din[7:5])
				3'b000: if (rd == 1'b0) dout <= 4'b1011; else dout <= 4'b0100;
				3'b001: dout <= 4'b1001;
				3'b010: dout <= 4'b0101;
				3'b011: if (rd == 1'b0) dout <= 4'b1100; else dout <= 4'b0011;
				3'b100: if (rd == 1'b0) dout <= 4'b1101; else dout <= 4'b0010;
				3'b101: dout <= 4'b1010;
				3'b110: dout <= 4'b0110;
				3'b111: if (rd == 1'b0) dout <= 4'b0111; else dout <= 4'b1000;
				default: dout <= dout;
			endcase
	end

endmodule