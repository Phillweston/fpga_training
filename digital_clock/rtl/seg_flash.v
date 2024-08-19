module seg_flash (
    input clk_1hz,
    input sys_rst_n,
    input key_switch_flag,
    input [2:0] sel_in,
    input [7:0] seg_in,
    output reg [2:0] sel_out,
    output reg [7:0] seg_out
);
    // State encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    reg [1:0] current_state, next_state;
    reg toggle;

    // State register
    always @(posedge clk_1hz or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            current_state <= STATE_0;
            toggle <= 1'b0;
        end else begin
            current_state <= next_state;
            toggle <= ~toggle;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = key_switch_flag ? STATE_1 : STATE_0;
            STATE_1: next_state = key_switch_flag ? STATE_2 : STATE_1;
            STATE_2: next_state = key_switch_flag ? STATE_3 : STATE_2;
            STATE_3: next_state = key_switch_flag ? STATE_0 : STATE_3;
            default: next_state = STATE_0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_0: begin
                sel_out = sel_in;
                seg_out = seg_in;
            end
            STATE_1, STATE_2, STATE_3: begin
                sel_out = sel_in;
                seg_out = toggle ? seg_in : 8'b0000_0000;
            end
            default: begin
                sel_out = 3'b000;
                seg_out = 8'b00000000;
            end
        endcase
    end
endmodule