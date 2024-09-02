//2:FSM实现(三段式FSM)
module seg_ctrl (
    input							clk_1khz,
    input							sys_rst_n,
    input				[23:0]	data_in,
    
    output	reg	[2:0]		sel,
    output	reg	[7:0]		seg
);
    reg				[3:0]		data_temp;
    reg				[2:0]		current_state;
    reg				[2:0]		next_state;
    
    parameter					s0 = 3'h0;
    parameter					s1 = 3'h1;
    parameter					s2 = 3'h2;
    parameter					s3 = 3'h3;
    parameter					s4 = 3'h4;
    parameter					s5 = 3'h5;

    //FSM实现
    always @ (posedge clk_1khz, negedge sys_rst_n)	begin	:	FSM_3S_1_CN_Moore
        if(sys_rst_n == 1'b0)
            current_state <= s0;
        else
            current_state <= next_state;
    end
    
    always @ (*)	begin	:	FSM_3S_2_ON_Moore
        next_state = 3'hx;
        case(current_state)
                s0		:		next_state = s1;
                s1		:		next_state = s2;
                s2		:		next_state = s3;
                s3		:		next_state = s4;
                s4		:		next_state = s5;
                s5		:		next_state = s0;
                
                default	:	next_state = s0;
        endcase
    end
    
    always @ (posedge clk_1khz, negedge sys_rst_n)	begin	:	FSM_3S_3_CN_Moore
        if(sys_rst_n == 1'b0)	begin
            sel <= 3'd0;
            data_temp <= 4'h0;
        end
        else
            case(current_state)
                s0			:	begin	sel <= 3'd0; data_temp <= data_in[23:20];	end
                s1			:	begin	sel <= 3'd1; data_temp <= data_in[19:16];	end
                s2			:	begin	sel <= 3'd2; data_temp <= data_in[15:12];	end
                s3			:	begin	sel <= 3'd3; data_temp <= data_in[11:8];	end
                s4			:	begin	sel <= 3'd4; data_temp <= data_in[7:4];	end
                s5			:	begin	sel <= 3'd5; data_temp <= data_in[3:0];	end
                
                default	:	begin	sel <= 3'd0; data_temp <= data_in[23:20];	end
            endcase
    end
    
    //对数码管进行译码
    always @ (*)	begin
        if(sys_rst_n == 1'b0)
            seg = 8'b1100_0000;
        else
            case(data_temp)
                4'd0		:		seg = 8'b1100_0000;				//0
                4'd1		:		seg = 8'b1111_1001;				//1
                4'd2		:		seg = 8'b1010_0100;				//2
                4'd3		:		seg = 8'b1011_0000;				//3
                
                4'd4		:		seg = 8'b1001_1001;				//4
                4'd5		:		seg = 8'b1001_0010;				//5
                4'd6		:		seg = 8'b1000_0010;				//6
                4'd7		:		seg = 8'b1111_1000;				//7
                
                4'd8		:		seg = 8'b1000_0000;				//8
                4'd9		:		seg = 8'b1001_0000;				//9
                4'd10		:		seg = 8'b1000_1000;				//A
                4'd11		:		seg = 8'b1000_0011;				//b
                
                4'd12		:		seg = 8'b1100_0110;				//C
                4'd13		:		seg = 8'b1010_0001;				//d
                4'd14		:		seg = 8'b1000_0110;				//E
                4'd15		:		seg = 8'b1111_1111;				//F
                
                default	:		seg = 8'b1100_0000;				//0
            endcase
    end

endmodule
