module uart_receiver (
    input sys_clk,
    input sys_rst_n,
    input rxd,
    output [2:0] sel,
    output [7:0] seg
);
    wire uart_clk;
    wire locked;

    wire [7:0] rec_data;   // received data
    wire rec_flag;         // received data flag

    wire rd_clk;
    wire [7:0] rd_data;

    clk_gen clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (uart_clk),
        .locked (locked)
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
        .sys_rst_n (locked),
        .rxd (rxd),
        .rec_data (rec_data),  // received data
        .rec_flag (rec_flag)         // received data flag
    );

    seven_tube seven_tube_ist (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .data_in ({16'hffff, rd_data}),
        .sel (sel),
        .seg (seg)
    );
endmodule