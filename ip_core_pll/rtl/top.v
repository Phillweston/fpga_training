module top (
    input sys_clk,
    input sys_rst_n,
    output [3:0] led
);
    wire clk_25mhz;
    wire clk_75mhz;
    wire clk_100mhz;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_25mhz),
        .c1 (clk_75mhz),
        .c2 (clk_100mhz),
        .locked (locked)
    );

    led_ctrl led_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_25mhz (clk_25mhz),
        .clk_75mhz (clk_75mhz),
        .clk_100mhz (clk_100mhz),
        .led (led)
    );
endmodule