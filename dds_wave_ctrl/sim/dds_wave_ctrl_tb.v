`timescale 1ns/1ps

module dds_wave_ctrl_tb;
    reg clock;
    reg sys_rst_n;
    reg key_switch;
    reg key_mode;
    reg key_add;
    reg key_sub;

    wire [7:0] q;
    defparam dds_wave_ctrl_inst.div_clk_inst.CNT_MAX = 5;
    defparam dds_wave_ctrl_inst.key_filter_inst1.T10ms = 10;
    defparam dds_wave_ctrl_inst.key_filter_inst2.T10ms = 10;
    defparam dds_wave_ctrl_inst.key_filter_inst3.T10ms = 10;
    defparam dds_wave_ctrl_inst.key_filter_inst4.T10ms = 10;

    dds_wave_ctrl dds_wave_ctrl_inst (
        .sys_clk (clock),
        .sys_rst_n (sys_rst_n),
        .key_switch (key_switch),
        .key_mode (key_mode),
        .key_add (key_add),
        .key_sub (key_sub),
        .q (q)
    );

    initial clock = 1'b1;
    always #10 clock = ~clock;

    // TODO:
    initial begin
        sys_rst_n = 1'b0;
        key_switch = 1'b0;
        key_mode = 1'b0;
        key_add = 1'b0;
        key_sub = 1'b0;

        #200.1 sys_rst_n = 1'b1;

        ////////////// Stage 1: Test the waveform switch ///////////////
        #1000;
        repeat (4) begin
            // Simulate the key press jitter
            #10_000_000 key_switch = 1'b1;
            #10 key_switch = 1'b0;
            #5 key_switch = 1'b1;
            #10 key_switch = 1'b0;
            #5 key_switch = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_switch = 1'b0;
            #10 key_switch = 1'b1;
            #5 key_switch = 1'b0;
            #10 key_switch = 1'b1;
            #5 key_switch = 1'b0;     // key released
        end

        ////////////// Stage 2: Test the waveform adjustment ///////////////
        #1000;
        repeat (2) begin
            // Simulate the key press jitter
            #10_000_000 key_mode = 1'b1;
            #10 key_mode = 1'b0;
            #5 key_mode = 1'b1;
            #10 key_mode = 1'b0;
            #5 key_mode = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_mode = 1'b0;
            #10 key_mode = 1'b1;
            #5 key_mode = 1'b0;
            #10 key_mode = 1'b1;
            #5 key_mode = 1'b0;     // key released

            repeat (2) begin                
                // Simulate the key press jitter
                #10_000_000 key_add = 1'b1;
                #10 key_add = 1'b0;
                #5 key_add = 1'b1;
                #10 key_add = 1'b0;
                #5 key_add = 1'b1;     // key pressed

                // Simulate the key release jitter
                #1000 key_add = 1'b0;
                #10 key_add = 1'b1;
                #5 key_add = 1'b0;
                #10 key_add = 1'b1;
                #5 key_add = 1'b0;     // key released
            end

            repeat (2) begin                
                // Simulate the key press jitter
                #10_000_000 key_sub = 1'b1;
                #10 key_sub = 1'b0;
                #5 key_sub = 1'b1;
                #10 key_sub = 1'b0;
                #5 key_sub = 1'b1;     // key pressed

                // Simulate the key release jitter
                #1000 key_sub = 1'b0;
                #10 key_sub = 1'b1;
                #5 key_sub = 1'b0;
                #10 key_sub = 1'b1;
                #5 key_sub = 1'b0;     // key released
            end
        end
        #10_000_000 $stop;
    end
endmodule