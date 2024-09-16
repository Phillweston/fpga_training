// Use software filtering (delay: 10ms)
// Output peak pulse when the key is pressed or released
module key_filter (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output reg key_out
);
    reg state;
    reg [31:0] cnt;

    parameter T10ms = 50_000_000 / 100;         // 10ms
    parameter s0 = 1'b0;
    parameter s1 = 1'b1;

    always @(posedge sys_clk or negedge sys_rst_n) begin : FSM_1S_CN_Mealy
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            state <= s0;
            key_out <= 1'b1;
        end else begin
            key_out <= 1'b0;
            case (state)
                s0: begin
                    if (~key_in) begin          // The key is pressed
                        if (cnt < T10ms - 1'd1) begin
                            cnt <= cnt + 1;
                        end else begin
                            cnt <= 32'd0;
                            key_out <= 1'b1;    // Output high pulse when the key is confirmed pressed
                            state <= s1;
                        end
                    end else begin
                        cnt <= 32'd0;           // Reset the counter when the key is released
                    end
                end
                s1: begin
                    if (key_in) begin           // The key is released
                        if (cnt <= T10ms - 1'd1) begin
                            cnt <= cnt + 1;
                        end else begin
                            cnt <= 32'd0;
                            key_out <= 1'b1;    // Output high pulse when the key is confirmed released
                            state <= s0;        // Waiting for the key to be pressed
                        end
                    end else begin
                        cnt <= 32'd0;           // Reset the counter when the key is pressed
                    end
                end
                default: state <= s0;
            endcase
        end
    end
endmodule