module dff_v1 (
    input sys_clk,
    input sys_rst_n,
    input d,
    output reg q
);
    // Behavior of a D flip-flop
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule