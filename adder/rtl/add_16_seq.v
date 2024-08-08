module add_16_seq (
    input sys_clk,
    input sys_rst,
    input [15:0] a,
    input [15:0] b,
    input ci,
    output reg [15:0] sum,
    output reg co
);
    reg [15:0] a_reg, b_reg;
    reg ci_reg;
    reg [16:0] result;

    // Use behavioral modeling to implement a 16-bit adder
    always @(posedge sys_clk or negedge sys_rst) begin
        if (sys_rst) begin
            sum <= 16'b0;
            co <= 1'b0;
            a_reg <= 16'b0;
            b_reg <= 16'b0;
            ci_reg <= 1'b0;
            result <= 17'b0;
        end else begin
            a_reg <= a;
            b_reg <= b;
            ci_reg <= ci;
            result <= {ci_reg, a_reg} + b_reg;
            sum <= result[15:0];
            co <= result[16];
        end
    end
endmodule