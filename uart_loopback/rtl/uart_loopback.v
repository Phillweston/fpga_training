module uart_loopback (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    input rxd,
    output txd,
    output [2:0] sel,
    output [7:0] seg
);
    wire uart_clk_9600;
    wire uart_clk_19200;
    wire uart_clk_38400;
    wire uart_clk_57600;
    wire uart_clk_115200;
    wire uart_clk;

    wire clk_1khz;            // 1kHz

    wire send_data_flag;
    wire [23:0] uart_baud;

    wire [7:0] rec_data;

    // Generate the 1kHz clock
    div_clk div_clk_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_1khz)
    );

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

    // Send the data to the UART
    uart_tx uart_tx_inst (
        .uart_clk (uart_clk),
        .sys_rst_n (sys_rst_n),
        .send_data (rec_data),      // sending data
        .rx_flag (rec_flag),
        .txd (txd),                 // uart data sending line
        .send_data_flag (send_data_flag)       // sending data flag
    );

    // Receive the data from the UART
    uart_rx uart_rx_inst (
        .uart_clk (uart_clk),             // 16*baud
        .sys_rst_n (sys_rst_n),
        .rxd (rxd),
        .rec_data (rec_data),  // received data
        .rec_flag (rec_flag)         // received data flag
    );

    // Select the baudrate and output the baudrate
    baud_select baud_select_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .uart_clk_9600 (uart_clk_9600),
        .uart_clk_19200 (uart_clk_19200),
        .uart_clk_38400 (uart_clk_38400),
        .uart_clk_57600 (uart_clk_57600),
        .uart_clk_115200 (uart_clk_115200),
        .uart_clk (uart_clk),
        .uart_baud (uart_baud)
    );

    // Display the baudrate on the 7-segment display
    seg_ctrl seg_ctrl_inst (
        .clk_1khz (clk_1khz),
        .sys_rst_n (sys_rst_n),
        .data_in (uart_baud),
        .sel (sel),
        .seg (seg)
    );
endmodule