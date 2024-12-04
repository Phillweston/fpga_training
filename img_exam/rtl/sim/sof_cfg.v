module sof_cfg
(
	//ϵͳ���
	input					clk,	//ϵͳʱ��
	input					rst_n,	//ϵͳ��λ
	//ϵͳ�������
	output	reg				bus_cs_n_o,	//ϵͳ����Ƭѡ���͵�ƽ��Ч
	output	reg				bus_we_o,	/*	ϵͳ����дʹ��
											bus_we_o
											1��д
											0����*/
	output reg [31:0]		bus_addr_o,	//ϵͳ���߿ռ��ַ��Ĭ��32λ��ַ�ռ�
	input					bus_ack_i,	//�ӻ�Ӧ��bus_ack_i==1��ʾ�ӻ���Ӧ
	output reg [31:0]		bus_data_o,	//ϵͳ���������ź�
	input [31:0]			bus_data_i,	
	//�ж��ź�
	input					irq	//��Ƶͼ�����ж��ź�

);
	localparam IBASE_SEC_CFG = 3'd0,
			   IBASE_DEC_CFG = 3'd1,
			   START_CFG = 3'd2,
			   WAIT_IRQ = 3'd3,
			   STATUS_RD = 3'd4;
	reg [2:0] state;
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			state <= IBASE_SEC_CFG;
		else case (state)
			IBASE_SEC_CFG:
				if (bus_ack_i)
					state <= IBASE_DEC_CFG;
			IBASE_DEC_CFG:
				if (bus_ack_i)
					state <= START_CFG;
			START_CFG:
				if (bus_ack_i)
					state <= WAIT_IRQ;
			WAIT_IRQ:
				if (irq)
					state <= STATUS_RD;
			STATUS_RD:
				if (bus_ack_i & bus_data_i[0])
					state  <=   START_CFG;
			default:
				state <= IBASE_SEC_CFG;
		endcase

	always @(posedge clk or	negedge rst_n)
		if (~rst_n) begin
			bus_cs_n_o <= 1'b1;
			bus_we_o <= 1'b0;
			bus_addr_o <= 32'd0;
			bus_data_o <= 32'd0;
		end else case(state)
			IBASE_SEC_CFG: begin
				if (bus_ack_i)
					bus_cs_n_o <= 1'b1;
				else 
					bus_cs_n_o <= 1'b0;
				
				bus_we_o <= 1'b1;
				bus_addr_o <= 32'h8000_0000 + (0 * 4);
				bus_data_o <= 32'h0000_0000;
			end
			IBASE_DEC_CFG: begin
				if (bus_ack_i)
					bus_cs_n_o <= 1'b1;
				else
					bus_cs_n_o <= 1'b0;
				
				bus_we_o <= 1'b1;
				bus_addr_o <= 32'h8000_0000 + (1 * 4);
				bus_data_o <= 32'd480000;
			end
			START_CFG: begin
				if (bus_ack_i)
					bus_cs_n_o <= 1'b1;
				else
					bus_cs_n_o <= 1'b0;
				
				bus_we_o <= 1'b1;
				bus_addr_o <= 32'h8000_0000 + (2 * 4);
				bus_data_o <= 32'dx;
			end
			STATUS_RD: begin
				if (bus_ack_i)
					bus_cs_n_o <= 1'b1;
				else
					bus_cs_n_o <= 1'b0;
				
				bus_we_o <= 1'b0;
				bus_addr_o <= 32'h8000_0000 + (3 * 4);
				bus_data_o <= 32'dx;
			end
			default:
				bus_cs_n_o <= 1'b1;
		endcase
endmodule