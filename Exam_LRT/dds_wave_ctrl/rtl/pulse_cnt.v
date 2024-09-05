module pulse_cnt (
    input sys_clk,
    input sys_rst_n,
    input key_pulse,
    output reg [1:0] pulse_cnt  // 2-bit counter to count from 0 to 3
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            pulse_cnt <= 2'd0;
        end else begin
            if (key_pulse) begin
                if (pulse_cnt == 2'd3) begin
                    pulse_cnt <= 2'd0;
                end else begin
                    pulse_cnt <= pulse_cnt + 2'd1;
                end
            end
        end
    end
endmodule