module add_16 (
    input [15:0] a,
    input [15:0] b,
    input [15:0] ci,
    output [15:0] sum,
    output co
);
    wire co1, co2, co3;

    add_4 add_4_inst1(
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(ci[0]),
        .sum(sum[3:0]),
        .co(co1)
    );

    add_4 add_4_inst2(
        .a(a[7:4]),
        .b(b[7:4]),
        .ci(co1),
        .sum(sum[7:4]),
        .co(co2)
    );

    add_4 add_4_inst3(
        .a(a[11:8]),
        .b(b[11:8]),
        .ci(co2),
        .sum(sum[11:8]),
        .co(co3)
    );

    add_4 add_4_inst4(
        .a(a[15:12]),
        .b(b[15:12]),
        .ci(co3),
        .sum(sum[15:12]),
        .co(co)
    );

endmodule