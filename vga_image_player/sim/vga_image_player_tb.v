`timescale 1ns/1ps

module vga_image_player_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_switch;
    reg key_zoom_in;
    reg key_zoom_out;
    wire vga_hsync;
    wire vga_vsync;
    wire [7:0] vga_rgb;

    defparam vga_image_player_inst.key_filter_inst1.T10ms = 5;
    defparam vga_image_player_inst.key_filter_inst2.T10ms = 5;
    defparam vga_image_player_inst.key_filter_inst3.T10ms = 5;

    vga_image_player vga_image_player_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_switch (key_switch),
        .key_zoom_in (key_zoom_in),
        .key_zoom_out (key_zoom_out),
        .vga_hsync (vga_hsync),       // line sync
        .vga_vsync (vga_vsync),       // field sync
        .vga_rgb (vga_rgb)    // rgb standard: 332
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_switch = 1'b0;
        key_zoom_in = 1'b0;
        key_zoom_out = 1'b0;
        #200.1
        sys_rst_n = 1'b1;

        repeat (4) begin
            // Simulate the key press jitter
            #10_000 key_switch = 1'b1;
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

        repeat (2) begin
            // Simulate the key press jitter
            #10_000 key_zoom_in = 1'b1;
            #10 key_zoom_in = 1'b0;
            #5 key_zoom_in = 1'b1;
            #10 key_zoom_in = 1'b0;
            #5 key_zoom_in = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_zoom_in = 1'b0;
            #10 key_zoom_in = 1'b1;
            #5 key_zoom_in = 1'b0;
            #10 key_zoom_in = 1'b1;
            #5 key_zoom_in = 1'b0;     // key released
        end

        repeat (4) begin
            // Simulate the key press jitter
            #10_000 key_zoom_out = 1'b1;
            #10 key_zoom_out = 1'b0;
            #5 key_zoom_out = 1'b1;
            #10 key_zoom_out = 1'b0;
            #5 key_zoom_out = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_zoom_out = 1'b0;
            #10 key_zoom_out = 1'b1;
            #5 key_zoom_out = 1'b0;
            #10 key_zoom_out = 1'b1;
            #5 key_zoom_out = 1'b0;     // key released
        end
        #10_000_000 $stop;
    end
endmodule