module seg_ctrl_sec (
    input sys_clk,
    input sys_rst_n,
    input key_pause_flag,
    input sec_add_flag,
    input sec_sub_flag,
    output reg [7:0] sec,
    output min_flag
);
    reg paused;

    // Add key pause logic
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            paused <= 1'b0;                     // Initial pause state as halt
        else if (paused && key_pause_flag)      // Press pause key to halt when starting
            paused <= 1'b0;                     // Halt
        else if (~paused && key_pause_flag)     // Press pause key to resume when halting
            paused <= 1'b1;                     // Start
        else
            paused <= paused;
    end

    reg [31:0] cnt;
    wire flag_1s;
    parameter T1s = 50_000_000 / 1;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 32'b0;
        else if (paused)
            cnt <= cnt;
        else if (cnt <= T1s - 1'd1)
            cnt <= cnt + 1'd1;
        else
            cnt <= 32'd0;
    end

    assign flag_1s = (cnt == T1s - 1'd1) ? 1'b1 : 1'b0;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            sec <= 8'd0;
        else if (flag_1s || sec_add_flag) begin
            if (sec < 8'd59)
                sec <= sec + 1'd1;
            else
                sec <= 8'd0;
        end else if (sec_sub_flag) begin
            if (sec > 8'd0)
                sec <= sec - 1'd1;
            else
                sec <= 8'd59;
        end else
            sec <= sec;
    end

    assign min_flag = (sec == 8'd59 && flag_1s) ? 1'b1 : 1'b0;
endmodule