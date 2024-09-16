`timescale 1ns/1ps

module uart_receiver_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg rxd;
    reg key_in;
    wire [2:0] sel;
    wire [7:0] seg;
    wire [3:0] led;

    defparam uart_receiver_inst.fifo_div_clk_inst.CNT_MAX = 2;
    defparam uart_receiver_inst.uart_clk_div_9600.SYS_CLK_FREQ = 5;
    defparam uart_receiver_inst.uart_clk_div_19200.SYS_CLK_FREQ = 5;
    defparam uart_receiver_inst.uart_clk_div_38400.SYS_CLK_FREQ = 5;
    defparam uart_receiver_inst.uart_clk_div_57600.SYS_CLK_FREQ = 5;
    defparam uart_receiver_inst.uart_clk_div_115200.SYS_CLK_FREQ = 5;
    defparam uart_receiver_inst.seven_tube_inst.clk_div_2khz_inst.CNT_MAX = 2;
    defparam uart_receiver_inst.baud_select_inst.key_filter_inst.T10ms = 5;

    uart_receiver uart_receiver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rxd (rxd),
        .key_in (key_in),
        .led (led),
        .sel (sel),
        .seg (seg)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        rxd = 1'b1;
        key_in = 1'b1;
        #200.1
        sys_rst_n = 1'b1;

        // Transmit a UART frame: 1 start bit, 8 data bits (0x55), 2 stop bits
        #2000 transmit_uart_frame(8'h55);
        simulate_key_action();

        // Transmit another UART frame: 1 start bit, 8 data bits (0xA3), 2 stop bits
        #2000 transmit_uart_frame(8'hA3);
        simulate_key_action();

        // Wait for the data to be received
        #2000 $finish;
    end

    task simulate_key_action;
    begin
        // Simulate the key press jitter
        #300_000 key_in = 1'b0;
        #10 key_in = 1'b1;
        #5 key_in = 1'b0;
        #10 key_in = 1'b1;
        #5 key_in = 1'b0;     // key pressed

        // Simulate the key release jitter
        #1000 key_in = 1'b1;
        #10 key_in = 1'b0;
        #5 key_in = 1'b1;
        #10 key_in = 1'b0;
        #5 key_in = 1'b1;     // key released    
    end
    endtask

    task transmit_uart_frame(input [7:0] data);
        integer i;
        begin
            // Start bit
            rxd = 1'b0;
            #(16 * 20); // 16x oversampling, 20ns per clock cycle

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                rxd = data[i];
                #(16 * 20); // 16x oversampling, 20ns per clock cycle
            end

            // Stop bits
            rxd = 1'b1;
            #(16 * 20 * 2); // 2 stop bits, 16x oversampling, 20ns per clock cycle
        end
    endtask

    initial begin
        $monitor("Time: %0t | Data: %h", $time, rxd);
    end
endmodule