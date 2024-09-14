module vga_block_catch (
    input sys_clk,
    input sys_rst_n,
    input key_left,             // key input left
    input key_right,            // key input right
    output vga_hsync,           // line sync
    output vga_vsync,           // field sync
    output [7:0] vga_rgb,       // rgb standard: 332
    output beep
);
    wire clk_40mhz;
    wire locked;

    wire [9:0] vga_xide;
    wire [9:0] vga_yide;
    wire [7:0] vga_data;       // VGA color data display

    wire block_caught_pulse;
    wire block_missed_pulse;
    wire [9:0] plate_x;            // plate x coordinate

    wire key_left_pulse;
    wire key_left_press;
    wire key_right_pulse;
    wire key_right_press;

    wire beep_caught;
    wire beep_missed;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_40mhz),             // 40MHz
        .locked (locked)
	);

    move_ctrl move_ctrl_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .vga_xide (vga_xide),
        .vga_yide (vga_yide),
        .plate_x (plate_x),
        .vga_data (vga_data),       // VGA color data display
        .block_caught_pulse (block_caught_pulse),       // signal indicating the block is caught
        .block_missed_pulse (block_missed_pulse)        // signal indicating the block is missed
    );

    beep_driver #(
        .MAX(50_000_000 / 2),     // 0.5s
        .T(50_000_000 / 2500)    // 2.5kHz
    ) beep_driver_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_flag (block_caught_pulse),
        .beep (beep_caught)
    );

    beep_driver #(
        .MAX(50_000_000 / 1),     // 1s
        .T(50_000_000 / 1000)    // 1kHz
    ) beep_driver_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_flag (block_missed_pulse),
        .beep (beep_missed)
    );

    assign beep = beep_caught | beep_missed;

    key_filter key_filter_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_in (key_left),
        .key_out (key_left_pulse)
    );

    key_toggle key_toggle_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_pulse (key_left_pulse),
        .key_press (key_left_press)
    );

    key_filter key_filter_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_in (key_right),
        .key_out (key_right_pulse)
    );

    key_toggle key_toggle_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_pulse (key_right_pulse),
        .key_press (key_right_press)
    );

    block_move block_move_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_left (key_left_press),
        .key_right (key_right_press),
        .plate_x (plate_x)
    );

    vga_ctrl vga_ctrl_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .vga_data (vga_data),
        .vga_xide (vga_xide),
        .vga_yide (vga_yide),
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb)
    );
endmodule