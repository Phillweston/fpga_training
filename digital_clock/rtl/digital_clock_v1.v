module digital_clock_v1 (
    input sys_clk,
    input sys_rst_n,
    input key_pause,
    input key_switch,
    input key_add,
    input key_sub,
    output [2:0] sel,
    output [7:0] seg,
    output beep
);
    wire [23:0] data_out;
    wire [11:0] bcd_hour;
    wire [11:0] bcd_min;
    wire [11:0] bcd_sec;
    wire [3:0] key_code;

    wire [7:0] bcd_hour_flash;
    wire [7:0] bcd_min_flash;
    wire [7:0] bcd_sec_flash;

    wire hour_en;
    wire min_en;
    wire sec_en;
    wire beep_add;
    wire beep_sub;

    logic_ctrl_v1 logic_ctrl_v1_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pause (key_pause),
        .key_add (key_add),
        .key_sub (key_sub),
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

    // Flash the hour segment
    seg_flash seg_flash_hour (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .bcd_input (bcd_hour[7:0]),
        .en_signal (hour_en),
        .bcd_output (bcd_hour_flash)
    );

    // Flash the minute segment
    seg_flash seg_flash_min (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .bcd_input (bcd_min[7:0]),
        .en_signal (min_en),
        .bcd_output (bcd_min_flash)
    );

    // Flash the second segment
    seg_flash seg_flash_sec (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .bcd_input (bcd_sec[7:0]),
        .en_signal (sec_en),
        .bcd_output (bcd_sec_flash)
    );
    
    // Switch key
    key_process key_process_switch (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_switch),
        .key_out_flag (key_switch_flag)
    );

    // Output hour, minute, and second enable signal
    key_flash_state key_flash_state_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_switch_flag (key_switch_flag),
        .hour_en (hour_en),
        .min_en (min_en),
        .sec_en (sec_en)
    );

    // First change and flash, then adjust the time
    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({bcd_hour_flash, bcd_min_flash, bcd_sec_flash}),
        .sel (sel),
        .seg (seg)
    );

    beep_driver beep_driver_add (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_flag (key_add),
        .beep (beep_sub)
    );

    beep_driver beep_driver_sub (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_flag (key_sub),
        .beep (beep_add)
    );

    // Combine the beep signals
    assign beep = beep_add | beep_sub;
endmodule