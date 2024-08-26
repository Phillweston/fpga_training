module pll (
    input sys_clk,
    input sys_rst_n,
    output locked,      // 0: output frequency not stable; 1: output frequency stable
    output clk_25mhz,
    output clk_100mhz
);
    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_25mhz),
        .c1 (clk_100mhz),
        .locked (locked)
    );
endmodule