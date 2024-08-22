module logic_ctrl_v1 (
    input sys_clk,
    input sys_rst_n,
    input key_pause,
    input key_add,
    input key_sub,
    output reg [23:0] data_out
);
    wire [7:0] sec;
    wire min_flag;
    wire [7:0] min;
    wire hour_flag;
    wire [7:0] hour;
    wire key_pause_flag;

    wire key_add_flag;
    wire key_sub_flag;

    // Pause key
    key_process key_process_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_pause),
        .key_out_flag (key_pause_flag)
    );

    // Increment key
    key_process key_process_increment (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_add),
        .key_out_flag (key_add_flag)
    );

    // Decrement key
    key_process key_process_decrement (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_sub),
        .key_out_flag (key_sub_flag)
    );

    // Second control
    seg_ctrl_sec seg_ctrl_sec_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pause_flag (key_pause_flag),
        .sec_add_flag (sec_add_flag),
        .sec_sub_flag (sec_sub_flag),
        .sec (sec),
        .min_flag (min_flag)
    );

    // Minute control
    seg_ctrl_min seg_ctrl_min_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .min_flag (min_flag),
        .min_add_flag (min_add_flag),
        .min_sub_flag (min_sub_flag),
        .min (min),
        .hour_flag (hour_flag)
    );

    // Hour control
    seg_ctrl_hour seg_ctrl_hour_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .hour_flag (hour_flag),
        .hour_add_flag (hour_add_flag),
        .hour_sub_flag (hour_sub_flag),
        .hour (hour)
    );

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_out <= 24'd0;
        else
            data_out <= {hour, min, sec};
    end
endmodule