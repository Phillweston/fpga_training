module pc_gen (
    // ϵͳ���
    input           clk,        // RISC���Ĺ���ʱ��
    input           rst_n,      // RISC��λ���͵�ƽ��Ч
    // ָ��ʱ��������
    input           en_inc,     // ��en_inc==1ʱ��pc�Լ�1
    input           ld_pc,      // ��ld_pc==1ʱ��pc����Ϊir[12:0]
    // ������ַ
    input   [12:0]  ir,         // ������ַ
    // ���ָ��ָ��
    output  reg [12:0] pc       // ָ��ָ��
);

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			pc <= 13'd0;
		else if (en_inc)
			pc <= pc + 1'b1;        // �Լ�1
		else if (ld_pc)
			pc <= ir;               // ��ת
	end

endmodule