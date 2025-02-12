module pulse_cnt (
    input sys_clk,
    input sys_rst_n,
    input key_pulse,
    output reg [1:0] pulse_cnt  // 2-bit counter to count from 0 to 2
);
    reg [1:0] counter;  // 2-bit counter to count from 0 to 1

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            counter <= 2'd0;
            pulse_cnt <= 2'd0;
        end else begin
            if (key_pulse) begin                
                if (counter == 2'd1) begin
                    counter <= 2'd0;
                    if (pulse_cnt == 2'd2) begin
                        pulse_cnt <= 2'd0;
                    end else begin
                        pulse_cnt <= pulse_cnt + 2'd1;
                    end
                end else begin
                    counter <= counter + 2'd1;
                end
            end
        end
    end
endmodule