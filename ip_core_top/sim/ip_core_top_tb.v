`timescale 1ns/1ps

module ip_core_top_tb;
    reg sys_clk;
    reg sys_rst_n;

    reg [4:0] key_num;
    reg [3:0] row_in;
    wire [3:0] col_out;
    wire beep;
    wire [2:0] sel;
    wire [7:0] seg;
    wire [1:0] led;

    // jitter time > 1000ns (20 * 5 * 10)ns
    defparam ip_core_top_inst.keyboard_scan_inst.T1ms = 5;
    defparam ip_core_top_inst.seven_tube_inst.div_clk_dut.CNT_MAX = 20;
    defparam ip_core_top_inst.beep_driver_inst.MAX = 10;
    defparam ip_core_top_inst.beep_driver_inst.T = 5;

    defparam ip_core_top_inst.dcfifo_div_clk_inst.CNT_MAX = 10;

    ip_core_top ip_core_top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .row_in (row_in),
        .col_out (col_out),
        .beep (beep),
        .led (led),
        .seg (seg),
        .sel (sel)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_num = 5'd16;

        #200.1 sys_rst_n = 1'b1;

        #3000 key_num = 5'd0;        // Press 0
        #3000 key_num = 5'd16;      // Release 0

        #3000 key_num = 5'd1;        // Press 1
        #3000 key_num = 5'd16;      // Release 1

        #3000 key_num = 5'd2;        // Press 2
        #3000 key_num = 5'd16;      // Release 2

        #3000 key_num = 5'd3;        // Press 3
        #3000 key_num = 5'd16;      // Release 3

        #3000 key_num = 5'd4;        // Press 4
        #3000 key_num = 5'd16;      // Release 4

        #3000 key_num = 5'd5;        // Press 5
        #3000 key_num = 5'd16;      // Release 5

        #3000 key_num = 5'd6;        // Press 6
        #3000 key_num = 5'd16;      // Release 6

        #3000 key_num = 5'd7;        // Press 7
        #3000 key_num = 5'd16;      // Release 7

        #3000 key_num = 5'd8;        // Press 8
        #3000 key_num = 5'd16;      // Release 8

        #3000 key_num = 5'd9;        // Press 9
        #3000 key_num = 5'd16;      // Release 9

        #3000 key_num = 5'd10;        // Press 10
        #3000 key_num = 5'd16;      // Release 10

        #3000 key_num = 5'd11;        // Press 11
        #3000 key_num = 5'd16;      // Release 11

        #3000 key_num = 5'd12;        // Press 12
        #3000 key_num = 5'd16;      // Release 12

        #3000 key_num = 5'd13;        // Press 13
        #3000 key_num = 5'd16;      // Release 13

        #3000 key_num = 5'd14;        // Press 14
        #3000 key_num = 5'd16;      // Release 14

        #3000 key_num = 5'd15;        // Press 15
        #3000 key_num = 5'd16;      // Release 15
    end

    always @(*) begin
        case (key_num)
            5'd0: row_in = {1'b1, 1'b1, 1'b1, col_out[0]};
            5'd1: row_in = {1'b1, 1'b1, 1'b1, col_out[1]};
            5'd2: row_in = {1'b1, 1'b1, 1'b1, col_out[2]};
            5'd3: row_in = {1'b1, 1'b1, 1'b1, col_out[3]};

            5'd4: row_in = {1'b1, 1'b1, col_out[0], 1'b1};
            5'd5: row_in = {1'b1, 1'b1, col_out[1], 1'b1};
            5'd6: row_in = {1'b1, 1'b1, col_out[2], 1'b1};
            5'd7: row_in = {1'b1, 1'b1, col_out[3], 1'b1};

            5'd8: row_in = {1'b1, col_out[0], 1'b1, 1'b1};
            5'd9: row_in = {1'b1, col_out[1], 1'b1, 1'b1};
            5'd10: row_in = {1'b1, col_out[2], 1'b1, 1'b1};
            5'd11: row_in = {1'b1, col_out[3], 1'b1, 1'b1};

            5'd12: row_in = {col_out[0], 1'b1, 1'b1, 1'b1};
            5'd13: row_in = {col_out[1], 1'b1, 1'b1, 1'b1};
            5'd14: row_in = {col_out[2], 1'b1, 1'b1, 1'b1};
            5'd15: row_in = {col_out[3], 1'b1, 1'b1, 1'b1};

            default: row_in = 4'b1111;
        endcase
    end
endmodule