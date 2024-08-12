module key_toggle (
    input sys_clk,
    input sys_rst_n,
    input key_pulse,
    output reg [1:0] toggle
);
    reg [1:0] pulse_cnt;

    // Update toggle state on key press/release event
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            pulse_cnt <= 2'b00;
            toggle <= 2'b00;
        end else if (key_pulse) begin
            if (pulse_cnt == 2'b01) begin
                if (toggle == 2'b10)
                    toggle <= 2'b00;    // Reset to 0 after reaching 2
                else
                    toggle <= toggle + 2'b01;   // Increment toggle state
                pulse_cnt <= 2'b00;     // Reset pulse counter after two pulses
            end else
                pulse_cnt <= pulse_cnt + 2'b01;
        end
    end
endmodule