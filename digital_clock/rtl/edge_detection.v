module edge_detection (
    input sys_clk,
    input sys_rst_n,
    input signal,
    output reg pos_edge,
    output reg neg_edge
);
    reg q1, q2;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            pos_edge <= 1'b0;
            neg_edge <= 1'b0;
        end else begin
            q1 <= signal;
            q2 <= q1;
            // Rising edge detection (signal transitions from 0 to 1)
            if (q1 == 1'b1 && q2 == 1'b0) begin
                pos_edge <= 1'b1;
            end else begin
                pos_edge <= 1'b0;
            end
            // Falling edge detection (signal transitions from 1 to 0)
            if (q1 == 1'b0 && q2 == 1'b1) begin
                neg_edge <= 1'b1;
            end else begin
                neg_edge <= 1'b0;
            end
        end
    end
endmodule