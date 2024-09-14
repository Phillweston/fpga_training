`timescale 1ns/1ps

module uart_tx_tb;
    reg uart_clk;
    reg sys_rst_n;
    reg [7:0] send_data;
    wire txd;
    wire send_data_flag;

    `define BAUD 9600
    `define TBAUD (1_000_000_000 / `BAUD)
    `define UART_CLK (16 * `BAUD)
    `define TUART_CLK (1_000_000_000 / `UART_CLK)
    `define TUART_CLK_HALF (`TUART_CLK / 2)

    uart_tx uart_tx_inst (
        .uart_clk (uart_clk),
        .sys_rst_n (sys_rst_n),
        .send_data (send_data),      // sending data
        .txd (txd),                 // uart data sending line
        .send_data_flag (send_data_flag)       // sending data flag
    );

    initial uart_clk = 1'b1;
    always #(`TUART_CLK_HALF) uart_clk = ~uart_clk;     // 16*9600 = 153600 Hz

    initial begin
        sys_rst_n = 1'b0;
        send_data = 8'h0;
        
        #200.1 sys_rst_n = 1'b1;

        #200 send_data = 8'h55;               // 8'b01010101
    end
endmodule