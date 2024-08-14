module bin2bcd_v2 (
    input [7:0] bin,
    output [11:0] bcd
);
    wire [19:0] bcd_data0;
    // 20 bits: 12 bits of bcd followed by the 8-bit input
    assign bcd_data0 = {12'h0, bin};
    wire [19:0] bcd_data1, bcd_data2, bcd_data3, bcd_data4;
    wire [19:0] bcd_data5, bcd_data6, bcd_data7, bcd_data8;

    bcd_modify bcd_modify_inst1 (
        .data_in (bcd_data0),
        .data_out (bcd_data1)
    );

    bcd_modify bcd_modify_inst2 (
        .data_in (bcd_data1),
        .data_out (bcd_data2)
    );

    bcd_modify bcd_modify_inst3 (
        .data_in (bcd_data2),
        .data_out (bcd_data3)
    );

    bcd_modify bcd_modify_inst4 (
        .data_in (bcd_data3),
        .data_out (bcd_data4)
    );

    bcd_modify bcd_modify_inst5 (
        .data_in (bcd_data4),
        .data_out (bcd_data5)
    );

    bcd_modify bcd_modify_inst6 (
        .data_in (bcd_data5),
        .data_out (bcd_data6)
    );

    bcd_modify bcd_modify_inst7 (
        .data_in (bcd_data6),
        .data_out (bcd_data7)
    );

    bcd_modify bcd_modify_inst8 (
        .data_in (bcd_data7),
        .data_out (bcd_data8)
    );

    assign bcd = bcd_data0[19:0];
endmodule