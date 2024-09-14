module uart_test (
    input sys_clk,
    input sys_rst_n,
    output txd
);
    wire uart_clk;
    wire locked;
    wire send_data_flag;

    // 0.1536 MHz
    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (uart_clk),
        .locked (locked)
	);

    uart_tx uart_tx_inst (
        .uart_clk (uart_clk),
        .sys_rst_n (sys_rst_n),
        .send_data (8'h55),      // sending data
        .txd (txd),                 // uart data sending line
        .send_data_flag (send_data_flag)       // sending data flag
    );
endmodule