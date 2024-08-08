module add_16_simple (
    input [15:0] a,
    input [15:0] b,
    input ci,
    output [15:0] sum,
    output co
);
    wire [16:0] full_sum;
    assign full_sum = {1'b0, a} + {1'b0, b} + ci;
    assign sum = full_sum[15:0];
    assign co = full_sum[16];
endmodule