module uart_receiver (
    input sys_clk,
    input sys_rst_n,
    input rxd,
    input key_in,
    output [3:0] led,
    output [2:0] sel,
    output [7:0] seg
);
    wire uart_clk_9600;
    wire uart_clk_19200;
    wire uart_clk_38400;
    wire uart_clk_57600;
    wire uart_clk_115200;
    wire uart_clk;

    wire [7:0] rec_data;   // received data
    wire rec_flag;         // received data flag

    wire rd_clk;
    wire [7:0] rd_data;

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
        .led (led)
    );

    fifo_div_clk fifo_div_clk_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (rd_clk)
    );

    rx_fifo	rx_fifo_inst (
        .data (rec_data),
        .rdclk (rd_clk),
        .rdreq (1'b1),
        .wrclk (uart_clk),
        .wrreq (rec_flag),
        .q (rd_data),
        .rdempty (),
        .wrfull ()
    );

    uart_rx uart_rx_inst (
        .uart_clk (uart_clk),             // 16*baud
        .sys_rst_n (sys_rst_n),
        .rxd (rxd),
        .rec_data (rec_data),  // received data
        .rec_flag (rec_flag)         // received data flag
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({16'hffff, rd_data}),
        .sel (sel),
        .seg (seg)
    );
endmodule