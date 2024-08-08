module and_gate_31 (
    input a,
    input b,
    input c,
    output s
);
    wire s1;

    and_gate and_gate_inst1(
        .a(a),
        .b(b),
        .s(s1)
    );

    and_gate and_gate_inst2(
        .a(s1),
        .b(c),
        .s(s)
    );
endmodule