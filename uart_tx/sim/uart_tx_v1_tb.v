`timescale 1ns/1ps

module uart_tx_v1_tb;
    reg uart_clk;
    reg sys_rst_n;
    reg [7:0] send_data;
    wire txd;
    wire send_data_flag;

    reg [7:0] data_temp;    // data waiting to be sent

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
        data_temp = 8'h0;
        
        #200.1 sys_rst_n = 1'b1;
        send_data = 8'h55;               // 8'b01010101

        #`TBAUD data_temp[0] = send_data[0];      // LSB
        #`TBAUD data_temp[1] = send_data[1];
        #`TBAUD data_temp[2] = send_data[2];
        #`TBAUD data_temp[3] = send_data[3];
        #`TBAUD data_temp[4] = send_data[4];
        #`TBAUD data_temp[5] = send_data[5];
        #`TBAUD data_temp[6] = send_data[6];
        #`TBAUD data_temp[7] = send_data[7];      // MSB
        #`TBAUD
        #`TBAUD;                                  // two stop bits

        send_data = 8'h66;               // 8'b01100110

        #`TBAUD data_temp[0] = send_data[0];      // LSB
        #`TBAUD data_temp[1] = send_data[1];
        #`TBAUD data_temp[2] = send_data[2];
        #`TBAUD data_temp[3] = send_data[3];
        #`TBAUD data_temp[4] = send_data[4];
        #`TBAUD data_temp[5] = send_data[5];
        #`TBAUD data_temp[6] = send_data[6];
        #`TBAUD data_temp[7] = send_data[7];      // MSB
        #`TBAUD
        #`TBAUD;                                  // two stop bits
        $stop;
    end
endmodule