module digital_clock_v2 (
    input sys_clk,
    input sys_rst_n,
    output [2:0] sel,
    output [7:0] seg
);
    wire [23:0] data_out;
    wire [11:0] bcd_hour;
    wire [11:0] bcd_min;
    wire [11:0] bcd_sec;

    logic_ctrl_v2 logic_ctrl_v2_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_out (data_out)
    );

    bin2bcd bin2bcd_inst_h (
        .bin (data_out[23:16]),
        .bcd (bcd_hour)
    );

    bin2bcd bin2bcd_inst_m (
        .bin (data_out[15:8]),
        .bcd (bcd_min)
    );

    bin2bcd bin2bcd_inst_l (
        .bin (data_out[7:0]),
        .bcd (bcd_sec)
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({bcd_hour[7:0], bcd_min[7:0], bcd_sec[7:0]}),
        .sel (sel),
        .seg (seg)
    );
endmodule