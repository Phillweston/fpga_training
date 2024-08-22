`timescale 1ns/1ps

module digital_clock_v1_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_pause;
    reg key_switch;
    reg key_add;
    reg key_sub;

    wire [2:0] sel;
    wire [7:0] seg;

    defparam digital_clock_v1_inst.logic_ctrl_v1_inst.seg_ctrl_sec_inst.T1s = 10;
    defparam digital_clock_v1_inst.seven_tube_inst.clk_div_1khz_inst.CNT_MAX = 10;
    defparam digital_clock_v1_inst.logic_ctrl_v1_inst.key_process_inst.key_filter_inst.T10ms = 10;
    defparam digital_clock_v1_inst.logic_ctrl_v1_inst.key_process_increment.key_filter_inst.T10ms = 10;
    defparam digital_clock_v1_inst.logic_ctrl_v1_inst.key_process_decrement.key_filter_inst.T10ms = 10;
    defparam digital_clock_v1_inst.seg_flash_hour.clk_div_1hz_inst.CNT_MAX = 10;
    defparam digital_clock_v1_inst.seg_flash_min.clk_div_1hz_inst.CNT_MAX = 10;
    defparam digital_clock_v1_inst.seg_flash_sec.clk_div_1hz_inst.CNT_MAX = 10;

    digital_clock_v1 digital_clock_v1_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pause (key_pause),
        .key_switch (key_switch),
        .key_add (key_add),
        .key_sub (key_sub),
        .sel (sel),
        .seg (seg),
        .beep (beep)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_pause = 1'b1;
        key_add = 1'b1;
        key_sub = 1'b1;
        key_switch = 1'b1;

        #200.1 sys_rst_n = 1'b1;

        #2000 key_pause = 1'b0;     // Start
        #500 key_pause = 1'b1;
        $display("Start");
        #500

        #2000 key_pause = 1'b0;     // Pause
        #500 key_pause = 1'b1;
        $display("Pause");

        #2000 key_pause = 1'b0;     // Resume
        #500 key_pause = 1'b1;
        $display("Resume");

        #2000 key_add = 1'b0;       // Increment
        #500 key_add = 1'b1;
        $display("Increment");

        #2000 key_sub = 1'b0;       // Decrement
        #500 key_sub = 1'b0;
        $display("Decrement");

        #2000 key_switch = 1'b0;    // Switch 1
        #500 key_switch = 1'b1;
        $display("Switch 1");

        #2000 key_switch = 1'b0;    // Switch 2
        #500 key_switch = 1'b1;
        $display("Switch 2");

        #2000 key_switch = 1'b0;    // Switch 3
        #500 key_switch = 1'b1;
        $display("Switch 3");

        #2000 key_switch = 1'b0;    // Switch 4
        #500 key_switch = 1'b1;
        $display("Switch 4");

        #2000;
    end
endmodule