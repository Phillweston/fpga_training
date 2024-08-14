module bcd2bin (
    input [15:0] bcd,
    output [13:0] bin
);
    // Maximum value of bcd is 9999
    assign bin =  bcd[15:12] * 1000 + bcd[11:8] * 100 + bcd[7:4] * 10 + bcd[3:0];
endmodule