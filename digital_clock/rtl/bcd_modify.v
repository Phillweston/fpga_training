module bcd_modify (
    input [19:0] data_in,
    output [19:0] data_out
);
    wire [3:0] cmp_data1;       // hundred digit
    wire [3:0] cmp_data2;       // ten digit
    wire [3:0] cmp_data3;       // one digit

    cmp cmp_high (
        .cmp_in (data_in[19:16]),
        .cmp_out (cmp_data1)
    );

    cmp cmp_middle (
        .cmp_in (data_in[15:12]),
        .cmp_out (cmp_data2)
    );

    cmp cmp_low (
        .cmp_in (data_in[11:8]),
        .cmp_out (cmp_data3)
    );

    // Left shift the hundred digit by 1 bit
    assign data_out = {cmp_data1[2:0], cmp_data2[3:0], cmp_data3[3:0], data_in[7:0], 1'b0};
endmodule