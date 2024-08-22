module seven_tube (
    input sys_clk,
    input sys_rst_n,
    input [23:0] data_in,
    output [2:0] sel,
    output [7:0] seg
);
    wire clk_1khz;

    // Generate 1khz clock for LED segment control
    clk_div_1khz clk_div_1khz_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_1khz)
    );

    // 8-segment led light control
    seg_ctrl seg_ctrl_inst (
        .clk_1khz (clk_1khz),
        .sys_rst_n (sys_rst_n),
        .data_in (data_in),
        .sel (sel),
        .seg (seg)
    );
endmodule