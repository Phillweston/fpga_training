`timescale 1ns/1ps

module uart_transmitter_tb;
    reg sys_clk;
    reg sys_rst_n;

    reg [4:0] key_num;
    reg [3:0] row;
    wire [3:0] col;
    wire txd;
    reg key_in;

    wire [2:0] sel;
    wire [7:0] seg;

    defparam uart_transmitter_inst.keyboard_scan_inst.T1ms = 5;     // 5ms
    defparam uart_transmitter_inst.div_clk_inst.CNT_MAX = 10;       // 10
    defparam uart_transmitter_inst.uart_clk_div_9600.SYS_CLK_FREQ = 5;
    defparam uart_transmitter_inst.uart_clk_div_19200.SYS_CLK_FREQ = 5;
    defparam uart_transmitter_inst.uart_clk_div_38400.SYS_CLK_FREQ = 5;
    defparam uart_transmitter_inst.uart_clk_div_57600.SYS_CLK_FREQ = 5;
    defparam uart_transmitter_inst.uart_clk_div_115200.SYS_CLK_FREQ = 5;
    defparam uart_transmitter_inst.baud_select_inst.key_filter_inst.T10ms = 5;

    uart_transmitter uart_transmitter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .row (row),
        .key_in (key_in),
        .txd (txd),
        .col (col),
        .sel (sel),
        .seg (seg)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_num = 5'd16;
        key_in = 1'b1;

        #200.1 sys_rst_n = 1'b1;
        // rd_data: 8'b00010001
        #100 key_num = 5'd1;        // Press 1
        #3000 key_num = 5'd16;      // Release 1
        simulate_key_action();

        // rd_data: 8'b00100010
        #3000 key_num = 5'd2;        // Press 2
        #3000 key_num = 5'd16;      // Release 2
        simulate_key_action();

        // rd_data: 8'b00110011
        #3000 key_num = 5'd3;        // Press 3
        #3000 key_num = 5'd16;      // Release 3
        simulate_key_action();

        // rd_data: 8'b01000100
        #3000 key_num = 5'd4;        // Press 4
        #3000 key_num = 5'd16;      // Release 4
        simulate_key_action();

        // rd_data: 8'b01010101
        #3000 key_num = 5'd5;        // Press 5
        #3000 key_num = 5'd16;      // Release 5
        simulate_key_action();

        #30_000 $stop;
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

    always @(*) begin
        case (key_num)
            5'd0: row = {1'b1, 1'b1, 1'b1, col[0]};
            5'd1: row = {1'b1, 1'b1, 1'b1, col[1]};
            5'd2: row = {1'b1, 1'b1, 1'b1, col[2]};
            5'd3: row = {1'b1, 1'b1, 1'b1, col[3]};

            5'd4: row = {1'b1, 1'b1, col[0], 1'b1};
            5'd5: row = {1'b1, 1'b1, col[1], 1'b1};
            5'd6: row = {1'b1, 1'b1, col[2], 1'b1};
            5'd7: row = {1'b1, 1'b1, col[3], 1'b1};

            5'd8: row = {1'b1, col[0], 1'b1, 1'b1};
            5'd9: row = {1'b1, col[1], 1'b1, 1'b1};
            5'd10: row = {1'b1, col[2], 1'b1, 1'b1};
            5'd11: row = {1'b1, col[3], 1'b1, 1'b1};

            5'd12: row = {col[0], 1'b1, 1'b1, 1'b1};
            5'd13: row = {col[1], 1'b1, 1'b1, 1'b1};
            5'd14: row = {col[2], 1'b1, 1'b1, 1'b1};
            5'd15: row = {col[3], 1'b1, 1'b1, 1'b1};

            default: row = 4'b1111;
        endcase
    end

    initial begin
        $monitor("Time: %0t | Data: %h", $time, txd);
    end
endmodule