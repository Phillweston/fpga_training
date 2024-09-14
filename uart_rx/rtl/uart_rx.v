`define EP (11 * 16 - 1)   // 11 bits per frame

module uart_rx (
    input uart_clk,             // 16*baud
    input sys_rst_n,
    input rxd,
    output reg [7:0] rec_data,  // received data
    output reg rec_flag         // received data flag
);
    // LSM_1S
    reg [7:0] cnt;              // counter
    reg state;

    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= s0;
            cnt <= 8'd0;
        end else begin
            case (state)
                s0: begin
                    if (~rxd) begin
                        state <= s1;
                        cnt <= 8'd0; // Reset counter when start bit is detected
                    end else begin
                        state <= s0;
                    end
                end
                s1: begin
                    if (cnt == `EP) begin
                        state <= s0;
                        cnt <= 8'd0;
                    end else begin
                        cnt <= cnt + 1'd1;
                    end
                end
                default: state <= s0;
            endcase
        end
    end

    reg [7:0] temp_data;        // register the received data
    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            temp_data <= 8'd0;
            rec_flag <= 1'b0;
            rec_data <= 8'd0;
        end else begin
            // Sample in the middle of the bit period
            case (cnt)
                1 * 16 + 7: temp_data[0] <= rxd;    // LSB
                2 * 16 + 7: temp_data[1] <= rxd;
                3 * 16 + 7: temp_data[2] <= rxd;
                4 * 16 + 7: temp_data[3] <= rxd;
                5 * 16 + 7: temp_data[4] <= rxd;
                6 * 16 + 7: temp_data[5] <= rxd;
                7 * 16 + 7: temp_data[6] <= rxd;
                8 * 16 + 7: temp_data[7] <= rxd;    // MSB
                9 * 16 + 1: begin
                    rec_data <= temp_data;
                    rec_flag <= 1'b1;
                end
                9 * 16 + 2: rec_flag <= 1'b0;
                default: rec_flag <= 1'b0;
            endcase
        end
    end
endmodule