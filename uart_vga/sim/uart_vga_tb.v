`timescale 1ns/1ps

module uart_vga_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg rxd;
    reg key_in;
    wire [2:0] sel;
    wire [7:0] seg;
    wire vga_hsync;
    wire vga_vsync;
    wire [7:0] vga_rgb;

    `define SYS_CLK_FREQ 50_000_000

    `define BAUD_9600 9600
    `define TBAUD_9600 (`SYS_CLK_FREQ / `BAUD_9600)

    `define BAUD_19200 19200
    `define TBAUD_19200 (`SYS_CLK_FREQ / `BAUD_19200)

    `define BAUD_38400 38400
    `define TBAUD_38400 (`SYS_CLK_FREQ / `BAUD_38400)

    `define BAUD_57600 57600
    `define TBAUD_57600 (`SYS_CLK_FREQ / `BAUD_57600)

    `define BAUD_115200 115200
    `define TBAUD_115200 (`SYS_CLK_FREQ / `BAUD_115200)

    defparam uart_vga_inst.baud_select_inst.key_filter_inst.T10ms = 5;

    uart_vga uart_vga_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .rxd (rxd),
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb),
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

        // Transmit a UART frame: 9600 baud_rate, 1 start bit, 8 data bits (0x55), 2 stop bits
        transmit_uart_frame(8'h55, `TBAUD_9600);
        simulate_key_action();

        // Transmit another UART frame: 19200 baud_rate, 1 start bit, 8 data bits (0xA3), 2 stop bits
        transmit_uart_frame(8'hA3, `TBAUD_19200);
        simulate_key_action();

        // Transmit another UART frame: 38400 baud_rate, 1 start bit, 8 data bits (0xA3), 2 stop bits
        transmit_uart_frame(8'hB7, `TBAUD_38400);
        simulate_key_action();

        // Transmit another UART frame: 57600 baud_rate, 1 start bit, 8 data bits (0xA3), 2 stop bits
        transmit_uart_frame(8'h89, `TBAUD_57600);
        simulate_key_action();

        // Transmit another UART frame: 115200 baud_rate, 1 start bit, 8 data bits (0xA3), 2 stop bits
        transmit_uart_frame(8'h89, `TBAUD_115200);
        simulate_key_action();

        // Wait for the data to be received
        //#20_000 $finish;
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

    task transmit_uart_frame(input [7:0] data, input integer baud_rate);
        integer i;
        begin
            #(baud_rate); // 16x oversampling, 20ns per clock cycle
            // Start bit
            rxd = 1'b0;

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                #(baud_rate); // 16x oversampling, 20ns per clock cycle
                rxd = data[i];
            end

            #(baud_rate); // 16x oversampling, 20ns per clock cycle
            // Stop bits
            rxd = 1'b1;
            #(baud_rate); // 16x oversampling, 20ns per clock cycle
            #(baud_rate); // 16x oversampling, 20ns per clock cycle

            #(16 * baud_rate); // 2 stop bits, 16x oversampling, 20ns per clock cycle
        end
    endtask

    initial begin
        $monitor("Time: %0t | Receive Data: %h | Send Data: %h", $time, rxd, txd);
    end
endmodule