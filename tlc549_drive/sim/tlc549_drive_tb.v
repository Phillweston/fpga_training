`timescale 1ns/1ps

module tlc549_drive_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg ad_data_out;
    wire ad_io_clock;
    wire ad_cs_n;
    reg en;
    wire [7:0] data;
    wire flag;

    tlc549_drive tlc549_drive_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .ad_data_out (ad_data_out),
        .en (en),
        .ad_io_clock (ad_io_clock),
        .ad_cs_n (ad_cs_n),
        .data (data),
        .flag (flag)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        ad_data_out = 1'b0;
        en = 1'b0;

        #200.1 sys_rst_n = 1'b1;

        // 8'b01010101
        #100 en = 1'b1;
        ad_data_out = 1'b0;                  // A7 (MSB)

        // a beat (20ns) before the cs_n pulling low, and lasting for 1400ns, the output the next data (500ns)
        #(1400+500+20) ad_data_out = 1'b1;   // A6
        #(50*20) ad_data_out = 1'b0;         // A5
        #(50*20) ad_data_out = 1'b1;         // A4
        #(50*20) ad_data_out = 1'b0;         // A3
        #(50*20) ad_data_out = 1'b1;         // A2
        #(50*20) ad_data_out = 1'b0;         // A1
        #(50*20) ad_data_out = 1'b1;         // A0
        #(50*20);
        #(17000) en = 1'b0;

        // 8'b10101010
        #100 en = 1'b1;
        ad_data_out = 1'b1;                  // A7 (MSB)

        // a beat (20ns) before the cs_n pulling low, and lasting for 1400ns, the output the next data (500ns)
        #(1400+500+20) ad_data_out = 1'b0;   // A6
        #(50*20) ad_data_out = 1'b1;         // A5
        #(50*20) ad_data_out = 1'b0;         // A4
        #(50*20) ad_data_out = 1'b1;         // A3
        #(50*20) ad_data_out = 1'b0;         // A2
        #(50*20) ad_data_out = 1'b1;         // A1
        #(50*20) ad_data_out = 1'b0;         // A0
        #(50*20);
        #(17000) en = 1'b0;

        #1000 $finish;
    end
endmodule