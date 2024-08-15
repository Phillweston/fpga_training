module pulse_cnt (
    input sys_clk,
    input sys_rst_n,
    input key_out_inc,
    input key_out_dec,
    output reg [23:0] cnt_data
);
    reg [7:0] counter;  // 8-bit counter to count from 0 to 255
    reg [1:0] pulse_cnt_inc;  // 2-bit counter to count key_out_inc pulses
    reg [1:0] pulse_cnt_dec;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            counter <= 8'd0;
            pulse_cnt_inc <= 2'd0;
        end else begin
            if (key_out_inc) begin                
                if (pulse_cnt_inc == 2'd1) begin
                    pulse_cnt_inc <= 2'd0;
                    if (counter == 8'd255) begin
                        counter <= 8'd0;
                    end else begin
                        counter <= counter + 1;
                    end
                end else begin
                    pulse_cnt_inc <= pulse_cnt_inc + 1;
                end
            end
            if (key_out_dec) begin
                if (pulse_cnt_dec == 2'd1) begin
                    pulse_cnt_dec <= 2'd0;
                    if (counter == 8'd0) begin
                        counter <= 8'd255;
                    end else begin
                        counter <= counter - 1;
                    end
                end else begin
                    pulse_cnt_dec <= pulse_cnt_dec + 1;
                end
            end
        end
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            cnt_data <= 24'd0;
        end else begin
            cnt_data <= {16'd0, counter};  // Assign the 8-bit counter to the lower 8 bits of cnt_data
        end
    end
endmodule