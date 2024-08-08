module cmp (
    input a,
    input b,
    output s
);
    assign s = (a > b) ? 1'b1 : 1'b0;
endmodule