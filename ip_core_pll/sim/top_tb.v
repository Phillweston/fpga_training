`timescale 1ns/1ps

module top_tb;
    reg sys_clk;
    reg sys_rst_n;

    wire [3:0] led;

    defparam top_inst.led_ctrl_inst.clk_div_25.CNT_MAX = 5;
    defparam top_inst.led_ctrl_inst.clk_div_50.CNT_MAX = 5;
    defparam top_inst.led_ctrl_inst.clk_div_75.CNT_MAX = 5;
    defparam top_inst.led_ctrl_inst.clk_div_100.CNT_MAX = 5;

    top top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 0;
        #10 sys_rst_n = 1;
        #1000 $finish;
    end
endmodule