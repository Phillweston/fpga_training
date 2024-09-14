`timescale 1ns/1ps

module uart_receiver_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg rx;
    wire [7:0] data;
    wire data_flag;

    uart_receiver uart_receiver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rx (rx),
        .data (data),
        .data_flag (data_flag)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b1;
        rx = 1'b1;
        #200.1
        sys_rst_n = 1'b0;

        // Transmit a UART frame: 1 start bit, 8 data bits (0x55), 2 stop bits
        #2000 transmit_uart_frame(8'h55);

        // Transmit another UART frame: 1 start bit, 8 data bits (0xA3), 2 stop bits
        #2000 transmit_uart_frame(8'hA3);

        // Wait for the data to be received
        #2000 $finish;
    end

    task transmit_uart_frame(input [7:0] data);
        integer i;
        begin
            // Start bit
            rx = 1'b0;
            #(16 * 20); // 16x oversampling, 20ns per clock cycle

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(16 * 20); // 16x oversampling, 20ns per clock cycle
            end

            // Stop bits
            rx = 1'b1;
            #(16 * 20 * 2); // 2 stop bits, 16x oversampling, 20ns per clock cycle
        end
    endtask

    initial begin
        $monitor("Time: %0t | Data: %h | Data Valid: %b", $time, data, data_flag);
    end
endmodule