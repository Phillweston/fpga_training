module key_filter (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output reg key_out
);
    reg [1:0] current_state;
    reg [1:0] next_state;
    reg [31:0] cnt;

    parameter T10ms = 50_000_000 / 100;         // 10ms
    parameter s0 = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;
    parameter s3 = 2'b11;

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_1S_CN_Mealy
        if (~sys_rst_n)
            current_state <= s0;
        else
            current_state <= next_state;
    end

    always @(*) begin : FSM_2S_ON_Mealy
        next_state = 2'bx;
        case (current_state)
            s0: begin                   // (Initial) The key is confirm released
                if (~key_in)
                    next_state = s1;
                else
                    next_state = s0;
            end
            s1: begin                   // The key is pressed
                if (~key_in) begin
                    if (cnt < T10ms - 1'd1)
                        next_state = s1;
                    else
                        next_state = s2;
                end else
                    next_state = s1;
            end
            s2: begin                   // The key is confirm pressed
                if (key_in)
                    next_state = s3;
                else
                    next_state = s2;
            end
            s3: begin                   // The key is released
                if (key_in) begin
                    if (cnt < T10ms - 1'd1)
                        next_state = s3;
                    else
                        next_state = s0;
                end else
                    next_state = s3;
            end
            default: next_state = s0;
        endcase
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_3S_3_CN_Mealy
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            key_out <= 1'b1;
        end else begin
            case (current_state)
                s1: begin
                    if (cnt < T10ms - 1'd1) begin
                        cnt <= cnt + 1;
                        key_out <= 1'b1;
                    end else begin
                        cnt <= 32'd0;
                        key_out <= 1'b0;
                    end
                end
                s3: begin
                    if (cnt < T10ms - 1'd1) begin
                        cnt <= cnt + 1;
                        key_out <= 1'b0;
                    end else begin
                        cnt <= 32'd0;
                        key_out <= 1'b1;
                    end
                end
                default: key_out <= key_out;
            endcase
        end
    end
endmodule