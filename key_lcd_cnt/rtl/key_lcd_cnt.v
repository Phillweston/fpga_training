module key_lcd_cnt (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output [2:0] sel,
    output [7:0] seg
);
    wire key_out;
    wire [23:0] cnt_data;

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in (cnt_data),
        .sel (sel),
        .seg (seg)
    );

    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .key_out (key_out)
    );

    pulse_cnt pulse_cnt_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_out (key_out),
        .cnt_data (cnt_data)
    );
endmodule