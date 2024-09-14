module baud_select (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    input uart_clk_9600,
    input uart_clk_19200,
    output reg uart_clk,
    output reg [23:0] uart_baud
);
    wire key_pulse;
    wire pulse_cnt;

    // Key filter (output the peak pulse)
    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .key_out (key_pulse)
    );

    // 2-bit counter to count from 0 to 1
    pulse_cnt pulse_cnt_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pulse (key_pulse),
        .pulse_cnt (pulse_cnt)
    );

    // Select baud rate
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            uart_clk <= uart_clk_9600;
            uart_baud <= {4'b1001, 4'b0110, 4'b0000, 4'b0000};      // "9600"
        end else begin
            case (pulse_cnt)
                2'b00: begin 
                    uart_clk <= uart_clk_9600;
                    uart_baud <= {4'b1001, 4'b0110, 4'b0000, 4'b0000};  // "9600"
                end
                2'b01: begin
                    uart_clk <= uart_clk_19200;
                    uart_baud <= {4'b0001, 4'b1001, 4'b0010, 4'b0000, 4'b0000}; // "19200"
                end
                default: begin
                    uart_clk <= uart_clk_9600;
                    uart_baud <= {4'b1001, 4'b0110, 4'b0000, 4'b0000};      // "9600"
                end
            endcase
        end
    end
endmodule