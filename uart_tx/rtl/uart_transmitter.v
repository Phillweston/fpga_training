module uart_transmitter (
    input sys_clk,
    input sys_rst_n,
    input [3:0] row,
    input key_in,
    output txd,
    output [3:0] col,
    output [2:0] sel,
    output [7:0] seg
);
    wire uart_clk_9600;
    wire uart_clk_19200;
    wire uart_clk;

    wire wr_clk;            // 1kHz
    wire [3:0] key_data;
    wire key_valid;

    wire rd_req;
    wire [7:0] rd_data;
    wire rd_empty;

    wire send_data_flag;
    wire [23:0] uart_baud;

    // Generate the 1kHz clock
    div_clk div_clk_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (wr_clk)
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

    // Scan the keyboard
    keyboard_scan keyboard_scan_inst (
        .sys_clk (sys_clk),                // System clock
        .sys_rst_n (sys_rst_n),               // Reset signal
        .row_in (row),                     // Rows input from the keyboard
        .col_out (col),                    // Columns output to the keyboard
        .key_data (key_data),              // Output the key data (4-bit binary encoding of the key position)
        .key_valid (key_valid)             // Output the key valid signal when the jitter is eliminated
    );

    // Read the data from the FIFO
    tx_fifo	tx_fifo_inst (
        .data ({key_data, key_data}),
        .rdclk (uart_clk),
        .rdreq (rd_req),
        .wrclk (wr_clk),
        .wrreq (key_valid),
        .q (rd_data),
        .rdempty (rd_empty),
        .wrfull ()
	);

    // Send the data to the UART
    uart_tx_v1 uart_tx_v1_inst (
        .uart_clk (uart_clk),
        .sys_rst_n (sys_rst_n),
        .send_data (rd_data),      // sending data
        .rd_empty (rd_empty),
        .rd_req (rd_req),
        .txd (txd),                 // uart data sending line
        .send_data_flag (send_data_flag)       // sending data flag
    );

    // Select the baudrate and output the baudrate
    baud_select baud_select_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .uart_clk_9600 (uart_clk_9600),
        .uart_clk_19200 (uart_clk_19200),
        .uart_clk (uart_clk),
        .uart_baud (uart_baud)
    );

    // Display the baudrate on the 7-segment display
    seg_ctrl seg_ctrl_inst (
        .clk_1khz (wr_clk),
        .sys_rst_n (sys_rst_n),
        .data_in (uart_baud),
        .sel (sel),
        .seg (seg)
    );
endmodule