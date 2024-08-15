module edge_detection (
    input sys_clk,
    input sys_rst_n,
    input signal,
    output reg q_out
);
    reg q1, q2;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q_out <= 1'b0; // Reset q_out here
        end else begin
            q1 <= signal;
            q2 <= q1;
            // Rising edge detection (signal transitions from 0 to 1)
            if (q1 == 1'b1 && q2 == 1'b0) begin
                q_out <= 1'b1; // Assign q_out in the same always block
            end else begin
                q_out <= 1'b0; // Ensure q_out is explicitly controlled here
            end
        end
    end
endmodule