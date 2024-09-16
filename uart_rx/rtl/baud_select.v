module baud_select (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    input uart_clk_9600,
    input uart_clk_19200,
    input uart_clk_38400,
    input uart_clk_57600,
    input uart_clk_115200,
    output reg uart_clk,
    output reg [3:0] led
);
    wire key_pulse;
    wire [2:0] pulse_cnt;

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
            led <= 4'b1110;
        end else begin
            case (pulse_cnt)
                3'b000: begin
                    uart_clk <= uart_clk_9600;
                    led <= 4'b1110;
                end
                3'b001: begin
                    uart_clk <= uart_clk_19200;
                    led <= 4'b1101;
                end
                3'b010: begin
                    uart_clk <= uart_clk_38400;
                    led <= 4'b1100;
                end
                3'b011: begin
                    uart_clk <= uart_clk_57600;
                    led <= 4'b1011;
                end
                3'b100: begin
                    uart_clk <= uart_clk_115200;
                    led <= 4'b1010;
                end
                default: begin
                    uart_clk <= uart_clk_9600;
                    led <= 4'b1110;
                end
            endcase
        end
    end
endmodule