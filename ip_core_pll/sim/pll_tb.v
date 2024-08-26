`timescale 1ns/1ps

module pll_tb;
    reg sys_clk;
    reg sys_rst_n;

    wire locked;
    wire clk_25mhz;
    wire clk_100mhz;

    pll pll_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (~sys_rst_n),
        .locked (locked),      // 0: output frequency not stable; 1: output frequency stable
        .clk_25mhz (clk_25mhz),
        .clk_100mhz (clk_100mhz)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 0;
        #10 sys_rst_n = 1;
        #1000 $finish;
    end
endmodule