`timescale 1ns/1ps

module uart_receiver_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg rxd;
    wire [2:0] sel;
    wire [7:0] seg;

    reg [7:0] data;     // simulate the received data

    `define BAUD 9600
    `define TBAUD (1_000_000_000 / `BAUD)
    `define UART_CLK (16 * `BAUD)
    `define TUART_CLK (1_000_000_000 / `UART_CLK)
    `define TUART_CLK_HALF (`TUART_CLK / 2)

    uart_receiver uart_receiver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rxd (rxd),
        .sel (sel),
        .seg (seg)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;     // 16*9600 = 153600 Hz

    initial begin
        sys_rst_n = 1'b0;
        rxd = 1'b1;
        data = 8'h0;

        #200.1 sys_rst_n = 1'b1;

        // Simulate the UART receiver
        #`TBAUD rxd = 1'b0;
        data = 8'h55;               // 8'b01010101
        #`TBAUD rxd = data[0];      // LSB
        #`TBAUD rxd = data[1];
        #`TBAUD rxd = data[2];
        #`TBAUD rxd = data[3];
        #`TBAUD rxd = data[4];
        #`TBAUD rxd = data[5];
        #`TBAUD rxd = data[6];
        #`TBAUD rxd = data[7];      // MSB
        #`TBAUD rxd = 1'b1;          // stop bit
        #`TBAUD
        #`TBAUD;

        // Simulate the UART receiver
        #`TBAUD rxd = 1'b0;
        data = 8'h66;               // 8'b01010101
        #`TBAUD rxd = data[0];      // LSB
        #`TBAUD rxd = data[1];
        #`TBAUD rxd = data[2];
        #`TBAUD rxd = data[3];
        #`TBAUD rxd = data[4];
        #`TBAUD rxd = data[5];
        #`TBAUD rxd = data[6];
        #`TBAUD rxd = data[7];      // MSB
        #`TBAUD rxd = 1'b1;          // stop bit
        #`TBAUD
        #`TBAUD;
    end
endmodule