module auto_machine_v3 (
    input sys_clk,
    input sys_rst_n,
    input one_rmb,
    input one_rmb_half,
    output reg drink,
    output reg change
);
    reg [2:0] current_state;
    reg [2:0] next_state;
    parameter s00 = 3'b000;
    parameter s05 = 3'b001;
    parameter s10 = 3'b010;
    parameter s15 = 3'b011;
    parameter s20 = 3'b100;
    parameter s25 = 3'b101;
    parameter s30 = 3'b110;
    parameter clear = 3'b111;

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_3S_1_CN_Melay
        if (~sys_rst_n)
            current_state <= s00;
        else
            current_state <= next_state;
    end

    always @(*) begin : FSM_3S_2_ON_Melay
        next_state = 3'bx;
        case (current_state)
            s00: begin
                if (one_rmb)
                    next_state = s10;
                else if (one_rmb_half)
                    next_state = s05;
                else
                    next_state = s00;
            end
            s05: begin
                if (one_rmb)
                    next_state = s15;
                else if (one_rmb_half)
                    next_state = s10;
                else
                    next_state = s05;
            end
            s10: begin
                if (one_rmb)
                    next_state = s20;
                else if (one_rmb_half)
                    next_state = s15;
                else
                    next_state = s10;
            end
            s15: begin
                if (one_rmb)
                    next_state = s25;
                else if (one_rmb_half)
                    next_state = s20;
                else
                    next_state = s15;
            end
            s20: begin
                if (one_rmb)
                    next_state = s30;
                else if (one_rmb_half)
                    next_state = s25;
                else
                    next_state = s20;
            end
            s25: begin
                next_state  = clear;
            end
            s30: begin
                next_state = clear;
            end
            clear: begin
                next_state = s00;
            end
            default: begin
                next_state = s00;
            end
        endcase
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_3S_3_ON_Melay
        if (~sys_rst_n) begin
            drink = 1'b0;
            change = 1'b0;
        end
        else begin
            case (current_state)
                s25: begin
                    drink = 1'b1;
                    change = 1'b0;
                end
                s30: begin
                    drink = 1'b1;
                    change = 1'b1;
                end
                clear: begin
                    drink = 1'b0;
                    change = 1'b0;
                end
                default: begin
                    drink = 1'b0;
                    change = 1'b0;
                end
            endcase
        end
    end
endmodule