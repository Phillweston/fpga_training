module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output carry
);
    // wire sum1;
    // wire carry1;
    // wire carry2;

    // half_adder half_adder_inst1(
    //     .a(a),
    //     .b(b),
    //     .sum(sum1),
    //     .carry(carry1)
    // );

    // half_adder half_adder_inst2(
    //     .a(s1),
    //     .b(cin),
    //     .sum(sum),
    //     .carry(carry2)
    // );

    // assign co = co1 | co2;
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule