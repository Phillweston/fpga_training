module digital_voltmeter (
    input sys_clk,
    input sys_rst_n,
    input ad_data_out,
    input key_in,
    output ad_io_clock,
    output ad_cs_n,
    output led,
    output [2:0] sel,
    output [7:0] seg
);
    wire key_out;
    wire flag;
    wire [7:0] data;
    wire [11:0] bin_data;
    wire [15:0] data_in;

    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .key_out (key_out)
    );

    tlc549_drive tlc549_drive_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .ad_data_out (ad_data_out),
        .en (~key_out),
        .ad_io_clock (ad_io_clock),
        .ad_cs_n (ad_cs_n),
        .data (data),
        .flag (flag)
    );

    ad_ctrl ad_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .flag (flag),
        .data (data),
        .cal_data (bin_data)
    );

    bin2bcd bin2bcd_inst (
        .bin (bin_data),
        .bcd (data_in)
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({8'hff, data_in}),
        .sel (sel),
        .seg (seg)
    );

    flag_led flag_led_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .flag (flag),
        .led (led)
    );
endmodule