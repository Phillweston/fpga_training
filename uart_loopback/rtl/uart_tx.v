module uart_tx (
    input uart_clk,
    input sys_rst_n,
    input [7:0] send_data,          // fifo data waiting to be sent
    input rx_flag,                  // fifo read empty flag
    output reg txd,                 // uart data sending line
    output reg send_data_flag       // sending data flag
);
    reg state;
    reg [7:0] cnt;

    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    `define EP1 12 * 16 - 1         // 2 stop bits + 8 data bits + start bit

    // LSM_1: sending data
    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= `EP1;
            state <= s0;
        end else begin
            case (state)
                s0: begin
                    if (cnt >= `EP1 && rx_flag) begin
                        cnt <= 8'd0;
                        state <= s1;
                    end else
                        state <= s0;
                end
                s1: begin
                    if (cnt < `EP1) begin
                        cnt <= cnt + 1'd1;
                        state <= s1;
                    end else begin
                        cnt <= `EP1;     // rep1etitive sending data
                        state <= s0;
                    end
                end
                default: state <= s0;
            endcase
        end
    end

    reg send_en;
    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            send_en <= 1'b0;
        else if (rx_flag)       // TODO:
            send_en <= 1'b1;
        else if (cnt >= `EP1)
            send_en <= 1'b0;
        else
            send_en <= send_en;
    end

    // LSM_2: perform actions
    reg [7:0] temp_data;
    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            temp_data <= 8'h0;
            txd <= 1'b1;
            send_data_flag <= 1'b0;
        end else if (send_en) begin
            case (cnt)
                0: txd <= 1'b0;                        // start bit
                1: temp_data <= send_data;              // open the FIFO read request (pull up for 1 time interval to read data for 1 time)
                1 * 16: txd <= temp_data[0];            // sending the first bit data
                2 * 16: txd <= temp_data[1];            // sending the second bit data
                3 * 16: txd <= temp_data[2];            // sending the third bit data
                4 * 16: txd <= temp_data[3];            // sending the fourth bit data
                5 * 16: txd <= temp_data[4];            // sending the fifth bit data
                6 * 16: txd <= temp_data[5];            // sending the sixth bit data
                7 * 16: txd <= temp_data[6];            // sending the seventh bit data
                8 * 16: txd <= temp_data[7];            // sending the eighth bit data
                9 * 16: txd <= 1'b1;                    // stop bit
                9 * 16 + 1: send_data_flag <= 1'b1;     // sending data flag
                9 * 16 + 2: send_data_flag <= 1'b0;     // reset sending data flag
                default: ;
            endcase
        end else
            txd <= 1'b1;
    end
endmodule