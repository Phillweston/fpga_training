module add_4 (
    input [3:0] a,
    input [3:0] b,
    input ci,
    output [3:0] sum,
    output co
);
    wire sum1, sum2, sum3;
    wire carry1, carry2, carry3;

    full_adder full_adder_inst1(
        .a(a[0]),
        .b(b[0]),
        .cin(ci),
        .sum(sum[0]),
        .carry(carry1)
    );

    full_adder full_adder_inst2(
        .a(a[1]),
        .b(b[1]),
        .cin(carry1),
        .sum(sum[1]),
        .carry(carry2)
    );

    full_adder full_adder_inst3(
        .a(a[2]),
        .b(b[2]),
        .cin(carry2),
        .sum(sum[2]),
        .carry(carry3)
    );

    full_adder full_adder_inst4(
        .a(a[3]),
        .b(b[3]),
        .cin(carry3),
        .sum(sum[3]),
        .carry(co)
    );

    // wire [4:0] full_sum;
    // assign full_sum = {1'b0, a} + {1'b0, b} + ci;
    // assign sum = full_sum[3:0];
    // assign co = full_sum[4];
endmodule