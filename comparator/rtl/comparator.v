module comparator (
    input [3:0] cnt1,
    input [3:0] cnt2,
    output valid
);
    assign valid = (cnt1 > cnt2) ? 1'b1 : 1'b0;
endmodule