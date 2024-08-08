module check_bin (
    input sys_clk,
    input sys_rst_n,
    input in_flow,
    output reg flag
);
    reg [2:0] current_state;
    reg [2:0] next_state;
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_3S_1_CN_Mealy
        if (!sys_rst_n)
            current_state <= s0;
        else
            current_state <= next_state;
    end

    always @(*) begin   : FSM_3S_2_ON_Mealy
        next_state = 3'bx;
        case (current_state)
            s0: begin
                if (in_flow)
                    next_state = s1;
                else
                    next_state = s0;
            end
            s1: begin
                if (in_flow)
                    next_state = s2;
                else
                    next_state = s0;
            end
            s2: begin
                if (in_flow)
                    next_state = s3;
                else
                    next_state = s2;
            end
            s3: begin
                if (in_flow)
                    next_state = s4;
                else
                    next_state = s0;
            end
            s4: begin
                if (in_flow)
                    next_state = s2;
                else
                    next_state = s0;
            end
            default: begin
                next_state = s0;
            end
        endcase
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_3S_3_ON_Mealy
        if (~sys_rst_n)
            flag <= 1'b0;
        else begin
            case (current_state)
                s3: begin
                    if (in_flow)
                        flag <= 1'b1;
                    else
                        flag <= 1'b0;
                end
                s4: flag <= 1'b0;
                default: flag <= 1'b0;      // Including s0, s1, s2
            endcase
        end
    end
endmodule