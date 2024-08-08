module check_characters (
    input sys_clk,
    input sys_rst_n,
    input [7:0] in_char,
    output reg flag
);
    // Check characters: 'Happy Day!'
    reg [3:0] current_state;
    reg [3:0] next_state;
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    parameter s9 = 4'b1001;
    parameter s10 = 4'b1010;

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_4S_1_CN_Mealy
        if (!sys_rst_n)
            current_state <= s0;
        else
            current_state <= next_state;
    end

    always @(*) begin : FSM_4S_2_ON_Mealy
        next_state = s0;
        case (current_state)
            s0: begin
                if (in_char == 8'h48) // 'H'
                    next_state = s1;
                else
                    next_state = s0;
            end
            s1: begin
                if (in_char == 8'h61) // 'a'
                    next_state = s2;
                else
                    next_state = s0;
            end
            s2: begin
                if (in_char == 8'h70) // 'p'
                    next_state = s3;
                else
                    next_state = s0;
            end
            s3: begin
                if (in_char == 8'h70) // 'p'
                    next_state = s4;
                else
                    next_state = s0;
            end
            s4: begin
                if (in_char == 8'h79) // 'y'
                    next_state = s5;
                else
                    next_state = s0;
            end
            s5: begin
                if (in_char == 8'h20) // ' '
                    next_state = s6;
                else
                    next_state = s0;
            end
            s6: begin
                if (in_char == 8'h44) // 'D'
                    next_state = s7;
                else
                    next_state = s0;
            end
            s7: begin
                if (in_char == 8'h61) // 'a'
                    next_state = s8;
                else
                    next_state = s0;
            end
            s8: begin
                if (in_char == 8'h79) // 'y'
                    next_state = s9;
                else
                    next_state = s0;
            end
            s9: begin
                if (in_char == 8'h21) // '!'
                    next_state = s10;
                else
                    next_state = s0;
            end
        endcase
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_4S_3_ON_Mealy
        if (!sys_rst_n)
            flag <= 1'b0;
        else begin
            case (current_state)
                s9: flag <= 1'b1;
                default: flag <= 1'b0;
            endcase
        end
    end
endmodule