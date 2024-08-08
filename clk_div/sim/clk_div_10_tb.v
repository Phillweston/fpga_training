`timescale 1ns/1ps

module clk_div_10_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire clk_div_10;

    clk_div_10 uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_div_10(clk_div_10)
    );

    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        #20.1 sys_rst_n = 1'b1;
        #1000 $finish;
    end

    always begin
        #20 sys_clk = ~sys_clk;
    end

endmodule