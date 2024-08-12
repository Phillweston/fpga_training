`timescale 1ns/1ps

module key_led_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_in;
    wire [3:0] led;

    defparam uut.key_filter_inst.T10ms = 5;     // 100 ns
    defparam uut.uut_clk_div.CNT_MAX = 50;
    defparam uut.uut_breath_led_1.T100 = 1;
    defparam uut.uut_breath_led_1.T2us = 10;
    defparam uut.uut_breath_led_1.T2ms = 10;
    defparam uut.uut_breath_led_2.T100 = 1;
    defparam uut.uut_breath_led_2.T2us = 10;
    defparam uut.uut_breath_led_2.T2ms = 10;

    key_led_top uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key_in),
        .led(led)
    );

    initial sys_clk = 1'b1;

    always #20 sys_clk = ~sys_clk;

    integer i;
    initial begin
        sys_rst_n = 1'b0;
        key_in = 1'b1;

        #200.1 sys_rst_n = 1'b1;
        #100 key_in = 1'b0;

        repeat (10) begin
            ////////////// Stage 1 ///////////////
            // Simulate the key press jitter
            #5 key_in = 1'b1;
            #10 key_in = 1'b0;
            #5 key_in = 1'b1;
            #10 key_in = 1'b0;

            // Simulate the key pressed
            #5000 key_in = 1'b1;

            // Simulate the key press jitter
            #5 key_in = 1'b0;
            #10 key_in = 1'b1;
            #5 key_in = 1'b0;
            #10 key_in = 1'b1;

            // Simulate the key released
            #5000 key_in = 1'b0;
        end
        $stop;
    end
endmodule