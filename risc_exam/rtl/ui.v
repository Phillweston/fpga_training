module ui (
    // ϵͳ���
    input           clk,            // RISC���Ĺ���ʱ��
    input           rst_n,          // RISC��λ���͵�ƽ��Ч
    // ������
    input   [15:13] ir,             // ָ�������
    // ָ��ʱ��������
    output          en_inc,         // ��en_inc==1ָ���ַ�Լ�1
    output          ld_pc,          // ��ld_pc==1ָ���ַ����Ϊ������ַ
    output          ld_ir,          // ��ld_ir==1��data_bus����ָ��
    output          en_alu,         // ��en_alu==1���ALU������
    output  reg     ld_acc,         // ��ld_acc==1����ALU���������ۼ���
    output          a_sel,          /* CPU���� ��ַ����ѡ��
                                       0��ָ���ַ
                                       1��������ַ */
    output          bus_data_link,  /* CPU��������������̬����
                                       1�����
                                       0������ */
    // CPU�����������
    output          wr,             // CPU��������д��Ч�ź�
    output          rd              // CPU�������߶���Ч�ź�
);

	localparam
		// ���Ƿ�    ������    ����
		NOP     = 3'b000,    // �ղ���
		LDA     = 3'b001,    // �Ӳ�����ַ��ָ��Ŀռ�������������ۼ�����
		STO     = 3'b010,    // ���ۼ�����д�������ַ��ָ��Ŀռ�
		ADD     = 3'b011,    // �Ӳ�����ַ��ָ��Ŀռ�����������ۼ�������ӣ���������ۼ���
		NXOR    = 3'b100,    // �Ӳ�����ַ��ָ��Ŀռ�����������ۼ���������򣬽�������ۼ���
		SFT     = 3'b101,    // �Ӳ�����ַ��ָ��Ŀռ��������,ѭ��������λ����������ۼ���
		SKP     = 3'b110,    // ������һ��ָ�ִ������һ��ָ��
		NJMP    = 3'b111;    // ��������ת��������ַ��ָ��Ŀռ�

	reg             clk_ir;
	reg     [1:0]   cnt_div;

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cnt_div <= 2'd0;
			clk_ir <= 1'b0;
		end else if (cnt_div == 2'd3) begin
			clk_ir <= ~clk_ir;
			cnt_div <= 2'd0;
		end else begin
			cnt_div <= cnt_div + 1'b1;
		end
	end

	reg     [2:0]   cnt;

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 3'd0;
		end else begin
			case (cnt)
				0: if (clk_ir) cnt <= cnt + 1'b1;
				3'd7: cnt <= 3'd0;
				default: cnt <= cnt + 1'b1;
			endcase
		end
	end

	wire    rd_fetch;
	reg     rd_exit;
	assign  rd = rd_fetch | rd_exit;

	wire    en_inc_fetch, en_inc_exit;
	assign  en_inc = en_inc_fetch | en_inc_exit;

	////////////////��ȡָ��(3/8)//////////////////////////////////////////////////////////
	assign  rd_fetch = ((cnt == 0) & (clk_ir == 1'b1)) | (cnt == 1); // ��ȡָ����Ҫ��2�Σ�bus_data[7:0]��ir[15:0]��
	assign  ld_ir = (cnt == 1) | (cnt == 2); // ��ָ��
	assign  en_inc_fetch = ((cnt == 0) & (clk_ir == 1'b1)) | (cnt == 1); // ָ���ַ+2

	////////////////����ִ��ָ�5/8����cnt == 3, 4, 5, 6, 7��//////////////////////////////////////////////////////////
	assign  en_alu = (cnt == 6);

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			ld_acc <= 1'b0;
		end else if (((ir[15:13] == LDA) | (ir[15:13] == ADD) | (ir[15:13] == NXOR) | (ir[15:13] == SFT)) & (cnt == 6)) begin
			ld_acc <= 1'b1;
		end else begin
			ld_acc <= 1'b0;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			rd_exit <= 1'b0;
		end else if (((ir[15:13] == LDA) | (ir[15:13] == ADD) | (ir[15:13] == NXOR) | (ir[15:13] == SFT)) & (cnt == 4)) begin
			rd_exit <= 1'b1;
		end else begin
			rd_exit <= 1'b0;
		end
	end

	assign  ld_pc = (ir[15:13] == NJMP) & (cnt == 7);
	assign  a_sel = (((cnt == 0) & (clk_ir == 1'b1)) | (cnt == 1)) ? 1'b0 : 1'b1;
	assign  wr = (ir[15:13] == STO) & (cnt == 7);
	assign  bus_data_link = (ir[15:13] == STO) & (cnt == 7);

	assign  en_inc_exit = (ir[15:13] == SKP) & ((cnt == 6) | (cnt == 7)) ? 1'b1 : 1'b0;

endmodule