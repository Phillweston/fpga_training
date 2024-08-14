`timescale 1ns/1ps

module key_led_v2_top_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_in;
    wire [3:0] led;
    wire [2:0] sel;
    wire [7:0] seg;

    defparam key_led_v2_top_inst.flow_led_inst.CNT_MAX = 50;

    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst1.T100 = 1;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst1.T2us = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst1.T2ms = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst2.T100 = 1;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst2.T2us = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst2.T2ms = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst3.T100 = 1;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst3.T2us = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst3.T2ms = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst4.T100 = 1;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst4.T2us = 10;
    defparam key_led_v2_top_inst.breath_led_top_inst.breath_led_inst4.T2ms = 10;

    defparam key_led_v2_top_inst.flash_led_inst.flash_led_inst1.CNT_MAX = 50;
    defparam key_led_v2_top_inst.flash_led_inst.flash_led_inst2.CNT_MAX = 50;
    defparam key_led_v2_top_inst.flash_led_inst.flash_led_inst3.CNT_MAX = 50;
    defparam key_led_v2_top_inst.flash_led_inst.flash_led_inst4.CNT_MAX = 50;

    defparam seven_tube_inst.clk_div_2khz_inst.CNT_MAX = 50;

    key_led_v2_top key_led_v2_top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .led (led),
        .sel (sel),
        .seg (seg)
    );

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

    always begin
        #20 sys_clk = ~sys_clk;
    end

endmodule