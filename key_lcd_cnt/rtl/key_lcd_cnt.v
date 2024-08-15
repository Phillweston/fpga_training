module key_lcd_cnt (
    input sys_clk,
    input sys_rst_n,
    input key_in_inc,
    input key_in_dec,
    output [2:0] sel,
    output [7:0] seg
);
    wire key_out_inc;
    wire key_out_dec;
    wire [23:0] cnt_data;

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in (cnt_data),
        .sel (sel),
        .seg (seg)
    );

    key_filter key_filter_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in_inc),
        .key_out (key_out_inc)
    );

    key_filter key_filter_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in_dec),
        .key_out (key_out_dec)
    );

    pulse_cnt pulse_cnt_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_out_inc (key_out_inc),
        .key_out_dec (key_out_dec),
        .cnt_data (cnt_data)
    );
endmodule