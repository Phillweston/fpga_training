module digital_clock_v1 (
    input sys_clk,
    input sys_rst_n,
    input key_pause,
    input key_switch,
    input [3:0] row_in,
    input [3:0] col_in,
    output [2:0] sel,
    output [7:0] seg
);
    wire [23:0] data_out;
    wire [11:0] bcd_hour;
    wire [11:0] bcd_min;
    wire [11:0] bcd_sec;
    wire [3:0] key_code;

    matrix_keyboard matrix_keyboard_inst (
        .sys_clk (sys_clk),                 // System clock
        .sys_rst_n (sys_rst_n),               // Reset signal
        .row_in (row_in),            // Rows input from the keyboard
        .col_in (col_in),            // Columns input from the keyboard
        .key_code (key_code)      // Output the key code (4-bit binary encoding of the key position)
    );

    logic_ctrl_v1 logic_ctrl_v1_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pause (key_pause),
        .key_code (key_code),
        .data_out (data_out)
    );

    bin2bcd bin2bcd_inst_h (
        .bin (data_out[23:16]),
        .bcd (bcd_hour)
    );

    bin2bcd bin2bcd_inst_m (
        .bin (data_out[15:8]),
        .bcd (bcd_min)
    );

    bin2bcd bin2bcd_inst_l (
        .bin (data_out[7:0]),
        .bcd (bcd_sec)
    );

    // First change and flash, then adjust the time
    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({bcd_hour[7:0], bcd_min[7:0], bcd_sec[7:0]}),
        .key_switch (key_switch),
        .sel (sel),
        .seg (seg)
    );
endmodule