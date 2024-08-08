module and_gate (
    input a,
    input b,
    output s
);
    // Use data flow to describe the AND gate
    assign s = a & b;
endmodule