`timescale 1ns/1ps

module vga_block_catch_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_left;
    reg key_right;
    wire vga_hsync;
    wire vga_vsync;
    wire [7:0] vga_rgb;
    wire beep;

    defparam vga_block_catch_inst.key_filter_inst1.T10ms = 5;
    defparam vga_block_catch_inst.key_filter_inst2.T10ms = 5;
    defparam vga_block_catch_inst.beep_driver_inst1.MAX = 1000;
    defparam vga_block_catch_inst.beep_driver_inst2.MAX = 1000;

    vga_block_catch vga_block_catch_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_left (key_left),             // key input left
        .key_right (key_right),           // key input right
        .vga_hsync (vga_hsync),           // line sync
        .vga_vsync (vga_vsync),           // field sync
        .vga_rgb (vga_rgb),               // rgb standard: 332
        .beep (beep)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        #200.1
        sys_rst_n = 1'b1;


        repeat (4) begin
            // Simulate the key press jitter
            #10_000 key_left = 1'b1;
            #10 key_left = 1'b0;
            #5 key_left = 1'b1;
            #10 key_left = 1'b0;
            #5 key_left = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_left = 1'b0;
            #10 key_left = 1'b1;
            #5 key_left = 1'b0;
            #10 key_left = 1'b1;
            #5 key_left = 1'b0;     // key released
        end

        repeat (2) begin
            // Simulate the key press jitter
            #10_000 key_right = 1'b1;
            #10 key_right = 1'b0;
            #5 key_right = 1'b1;
            #10 key_right = 1'b0;
            #5 key_right = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_right = 1'b0;
            #10 key_right = 1'b1;
            #5 key_right = 1'b0;
            #10 key_right = 1'b1;
            #5 key_right = 1'b0;     // key released
        end

        #10_000_000 $stop;
    end
endmodule