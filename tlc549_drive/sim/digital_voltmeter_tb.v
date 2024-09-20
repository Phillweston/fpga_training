`timescale 1ns/1ps

module digital_voltmeter_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg ad_data_out;
    wire ad_io_clock;
    wire ad_cs_n;
    reg key_in;
    wire led;
    wire [2:0] sel;
    wire [7:0] seg;

    defparam digital_voltmeter_inst.key_filter_inst.T10ms = 5;
    defparam digital_voltmeter_inst.seven_tube_inst.clk_div_2khz_inst.CNT_MAX = 5;

    digital_voltmeter digital_voltmeter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .ad_data_out (ad_data_out),
        .key_in (key_in),
        .ad_io_clock (ad_io_clock),
        .ad_cs_n (ad_cs_n),
        .led (led),
        .sel (sel),
        .seg (seg)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        ad_data_out = 1'b0;
        key_in = 1'b1;

        #200.1 sys_rst_n = 1'b1;

        #1000 key_in = 1'b0;

        // 8'b01010101
        ad_data_out = 1'b0;                  // A7 (MSB)
        #(1400+500+20) ad_data_out = 1'b1;   // A6
        #(50*20) ad_data_out = 1'b0;         // A5
        #(50*20) ad_data_out = 1'b1;         // A4
        #(50*20) ad_data_out = 1'b0;         // A3
        #(50*20) ad_data_out = 1'b1;         // A2
        #(50*20) ad_data_out = 1'b0;         // A1
        #(50*20) ad_data_out = 1'b1;         // A0
        #(50*20);
        #(17500);

        #1000 key_in = 1'b1;

        #1000 $finish;
    end
endmodule