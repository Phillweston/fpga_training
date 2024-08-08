`timescale 1ns/1ps

module led_top_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire [3:0] led;

    led_top uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led(led)
    );

    defparam uut.uut_clk_div.CNT_MAX = 50;
    defparam uut.uut_breath_led_1.T100 = 1;
    defparam uut.uut_breath_led_1.T2us = 10;
    defparam uut.uut_breath_led_1.T2ms = 10;
    defparam uut.uut_breath_led_2.T100 = 1;
    defparam uut.uut_breath_led_2.T2us = 10;
    defparam uut.uut_breath_led_2.T2ms = 10;

    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        #20.1 sys_rst_n = 1'b1;
    end

    always begin
        #20 sys_clk = ~sys_clk;
    end

endmodule