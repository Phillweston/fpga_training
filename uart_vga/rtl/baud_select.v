module baud_select (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output reg uart_clk,
    output reg [23:0] uart_baud
);
    wire key_pulse;
    wire [2:0] pulse_cnt;

    wire uart_clk_9600;
    wire uart_clk_19200;
    wire uart_clk_38400;
    wire uart_clk_57600;
    wire uart_clk_115200;

    // Generate the UART clock of 9600Hz
    uart_clk_div #(
        .BAUD_RATE(9600)
    ) uart_clk_div_9600 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .uart_clk (uart_clk_9600)
    );

    // Generate the UART clock of 19200Hz
    uart_clk_div #(
        .BAUD_RATE(19200)
    ) uart_clk_div_19200 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .uart_clk (uart_clk_19200)
    );

    // Generate the UART clock of 38400Hz
    uart_clk_div #(
        .BAUD_RATE(38400)
    ) uart_clk_div_38400 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .uart_clk (uart_clk_38400)
    );

    // Generate the UART clock of 57600Hz
    uart_clk_div #(
        .BAUD_RATE(57600)
    ) uart_clk_div_57600 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .uart_clk (uart_clk_57600)
    );

    // Generate the UART clock of 115200Hz
    uart_clk_div #(
        .BAUD_RATE(115200)
    ) uart_clk_div_115200 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .uart_clk (uart_clk_115200)
    );

    // Key filter (output the peak pulse)
    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .key_out (key_pulse)
    );

    // 3-bit counter to count from 0 to 4
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
                3'b000: begin 
                    uart_clk <= uart_clk_9600;
                    uart_baud <= {4'b1001, 4'b0110, 4'b0000, 4'b0000};  // "9600"
                end
                3'b001: begin
                    uart_clk <= uart_clk_19200;
                    uart_baud <= {4'b0001, 4'b1001, 4'b0010, 4'b0000, 4'b0000}; // "19200"
                end
                3'b010: begin
                    uart_clk <= uart_clk_38400;
                    uart_baud <= {4'b0011, 4'b1000, 4'b0100, 4'b0000, 4'b0000}; // "38400"
                end
                3'b011: begin
                    uart_clk <= uart_clk_57600;
                    uart_baud <= {4'b0101, 4'b0111, 4'b0110, 4'b0000, 4'b0000}; // "57600"
                end
                3'b100: begin
                    uart_clk <= uart_clk_115200;
                    uart_baud <= {4'b0001, 4'b0001, 4'b0101, 4'b0010, 4'b0000, 4'b0000}; // "115200"
                end
                default: begin
                    uart_clk <= uart_clk_9600;
                    uart_baud <= {4'b1001, 4'b0110, 4'b0000, 4'b0000};      // "9600"
                end
            endcase
        end
    end
endmodule