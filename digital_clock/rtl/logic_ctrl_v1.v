module logic_ctrl_v1 (
    input sys_clk,
    input sys_rst_n,
    input key_pause,
    input [3:0] key_code,
    output reg [23:0] data_out
);
    wire [7:0] sec;
    wire min_flag;
    wire [7:0] min;
    wire hour_flag;
    wire [7:0] hour;
    wire key_pause_flag;

    wire key_increment;
    wire key_decrement;
    wire key_increment_flag;
    wire key_decrement_flag;

    // Output 0 when corresponding matrix key is pressed
    assign key_increment = (key_code == 4'b0000) ? 0 : 1;
    assign key_decrement = (key_code == 4'b0001) ? 0 : 1;

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
        .key_in (key_increment),
        .key_out_flag (key_increment_flag)
    );

    // Decrement key
    key_process key_process_decrement (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_decrement),
        .key_out_flag (key_decrement_flag)
    );

    // FIXME:
    seg_ctrl_sec seg_ctrl_sec_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pause_flag (key_pause_flag),
        .key_increment_flag (key_increment_flag),
        .key_decrement_flag (key_decrement_flag),
        .sec (sec),
        .min_flag (min_flag)
    );

    // FIXME:
    seg_ctrl_min seg_ctrl_min_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .min_flag (min_flag),
        .min (min),
        .hour_flag (hour_flag)
    );

    // FIXME:
    seg_ctrl_hour seg_ctrl_hour_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .hour_flag (hour_flag),
        .hour (hour)
    );

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_out <= 24'd0;
        else
            data_out <= {hour, min, sec};
    end
endmodule