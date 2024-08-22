module key_flash_state (
    input sys_clk,
    input sys_rst_n,
    input key_switch_flag,
    output reg hour_en,
    output reg min_en,
    output reg sec_en
);
    // State encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    reg [1:0] current_state, next_state;
    reg toggle;

    // State register
    always @(posedge sys_clk or negedge sys_rst_n) begin
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
        hour_en = (current_state == STATE_1) ? 1'b1 : 1'b0;
        min_en = (current_state == STATE_2) ? 1'b1 : 1'b0;
        sec_en = (current_state == STATE_3) ? 1'b1 : 1'b0;
    end
endmodule