`timescale 1ns/1ps

module led_driver_fsm_tb ();
    reg sys_clk;
    reg sys_rst_n;
    wire [3:0] led;

    defparam uut.led_driver_fsm.uut_clk_div_2hz.CNT_MAX = 25;

    led_driver_fsm uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led(led)
    );

    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        #20.1 sys_rst_n = 1'b1;
    end

    always begin
        #20 sys_clk = ~sys_clk;
    end
endmodule