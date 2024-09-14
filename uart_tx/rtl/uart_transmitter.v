module uart_transmitter (
    input sys_clk,
    input sys_rst_n,
    input [3:0] row,
    output txd,
    output [3:0] col
);
    wire locked;
    wire uart_clk;

    wire wr_clk;
    wire [3:0] key_data;
    wire key_valid;

    wire rd_req;
    wire [7:0] rd_data;
    wire rd_empty;

    wire send_data_flag;

    div_clk div_clk_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .clk_out (wr_clk)
    );

    clk_gen clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (uart_clk),
        .locked (locked)
	);

    keyboard_scan keyboard_scan_inst (
        .sys_clk (sys_clk),                 // System clock
        .sys_rst_n (locked),               // Reset signal
        .row_in (row),            // Rows input from the keyboard
        .col_out (col),      // Columns output to the keyboard
        .key_data (key_data),     // Output the key data (4-bit binary encoding of the key position)
        .key_valid (key_valid)           // Output the key valid signal when the jitter is eliminated
    );

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

    uart_tx_v1 uart_tx_v1_inst (
        .uart_clk (uart_clk),
        .sys_rst_n (locked),
        .send_data (rd_data),      // sending data
        .rd_empty (rd_empty),
        .rd_req (rd_req),
        .txd (txd),                 // uart data sending line
        .send_data_flag (send_data_flag)       // sending data flag
    );
endmodule