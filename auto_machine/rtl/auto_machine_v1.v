module auto_machine_v1 (
    input sys_clk,
    input sys_rst_n,
    input one_rmb,
    input one_rmb_half,
    output reg drink,
    output reg change
);
    reg [2:0] state;
    parameter s00 = 3'b000;
    parameter s05 = 3'b001;
    parameter s10 = 3'b010;
    parameter s15 = 3'b011;
    parameter s20 = 3'b100;
    parameter s25 = 3'b101;
    parameter s30 = 3'b110;
    parameter clear = 3'b111;

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_1S_1_CN_Melay
        if (~sys_rst_n) begin
            state <= s00;
            drink <= 1'b0;
            change <= 1'b0;
        end else begin
            case (state)
                s00: begin
                    if (one_rmb)
                        state <= s10;
                    else if (one_rmb_half)
                        state <= s05;
                    else
                        state <= s00;
                end
                s05: begin
                    if (one_rmb)
                        state <= s15;
                    else if (one_rmb_half)
                        state <= s10;
                    else
                        state <= s05;
                end
                s10: begin
                    if (one_rmb)
                        state <= s20;
                    else if (one_rmb_half)
                        state <= s15;
                    else
                        state <= s10;
                end
                s15: begin
                    if (one_rmb)
                        state <= s25;
                    else if (one_rmb_half)
                        state <= s20;
                    else
                        state <= s15;
                end
                s20: begin
                    if (one_rmb)
                        state <= s30;
                    else if (one_rmb_half)
                        state <= s25;
                    else
                        state <= s20;
                end
                s25: begin
                    state <= clear;
                    drink <= 1'b1;
                    change <= 1'b0;
                end
                s30: begin
                    state <= clear;
                    drink <= 1'b1;
                    change <= 1'b1;
                end
                clear: begin
                    drink <= 1'b0;
                    change <= 1'b0;
                    state <= s00;
                end
                default: begin
                    state <= s00;
                end
            endcase
        end
    end
endmodule