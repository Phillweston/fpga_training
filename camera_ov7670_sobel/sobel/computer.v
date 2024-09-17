module computer(clk, rst_n, mem_q, pr_load, cr_load, nr_load, shift_en, 
	rows_load, set_z, mem_data);

	input clk, rst_n;
	input [31:0] mem_q;
	input pr_load, cr_load, nr_load, shift_en;
	output [31:0] mem_data;
	input rows_load, set_z;

	reg [31:0] pr, cr, nr;
	reg [7:0] z [-1:1][-1:1];
	reg signed [10:0] dx, dy;
	reg [7:0] absd;
	reg [7:0] r0, r1, r2, r3, r4, r5;
	reg [31:0] prr, crr, nrr;
	
	always @ (posedge clk)
	begin :	PR
		if(!rst_n)
			pr <= 0;
		else if(pr_load)
			pr <= mem_q;
	end 
	
	always @ (posedge clk)
	begin :	CR
		if(!rst_n)
			cr <= 0;
		else if(cr_load)
			cr <= mem_q;
	end 
	
	always @ (posedge clk)
	begin :	NR
		if(!rst_n)
			nr <= 0;
		else if(nr_load)
			nr <= mem_q;
	end 
	
	always @(posedge clk)
	begin : XRR
		if(rows_load)
			begin
				prr <= pr;
				crr <= cr;
				nrr <= nr;
			end
		else if(shift_en)
			begin
				prr[31:8] <= prr[23:0];
				crr[31:8] <= crr[23:0];
				nrr[31:8] <= nrr[23:0];
			end
	end
	
	always @ (posedge clk)
	begin :	O
		if(shift_en) begin
			z[-1][1] <= prr[31:24];	//前一行进入右路
			z[0][1] <= crr[31:24];	//当前行进入右路
			z[1][1] <= nrr[31:24];	//下一行进入右路
			
			z[-1][0] <= z[-1][1];	//前行右路进入中路
			z[0][0] <= z[0][1];		//当前行右路进入中路
			z[1][0] <= z[1][1];		//下一行右路进入中路
			
			z[-1][-1] <= z[-1][0];	//前行中路进入左路
			z[0][-1] <= z[0][0];		//当前行中路进入左路
			z[1][-1] <= z[1][0];		//下一行中路进入左路
		end 
	end 

	always @ (posedge clk)
	begin :	DX_DY
		if(shift_en) begin 
			dx <= -$signed({3'b000, z[-1][-1]}) + $signed({3'b000, z[-1][1]}) - ($signed({3'b000, z[0][-1]})<<1) 
					+ ($signed({3'b000, z[0][1]})<<1) - $signed({3'b000, z[1][-1]}) + $signed({3'b000, z[1][1]});
			
			dy <= $signed({3'b000, z[-1][-1]}) + ($signed({3'b000, z[-1][0]})<<1) + $signed({3'b000, z[-1][1]})
					-$signed({3'b000, z[1][-1]}) - ($signed({3'b000, z[1][0]})<<1) - $signed({3'b000, z[1][1]});
		end 
	end 
	
	function [10:0] abs(input signed [10:0] x);
		abs = (x > 0) ? x : -x;
	endfunction
	
	always @ (posedge clk)
	begin : ABSD
		if(set_z)
			absd <= 0;
		else if(shift_en)
			absd <= (abs(dx) + abs(dy)) >> 3;
	end 
	
	always @ (posedge clk)
	begin :	DES
		if(shift_en) begin 
			r0 <= absd;
			r1 <= r0;
			r2 <= r1;
			r3 <= r2;
			r4 <= r3;
			r5 <= r4;
		end 
	end 
	
	assign mem_data = {r5, r4, r3, r2};

endmodule