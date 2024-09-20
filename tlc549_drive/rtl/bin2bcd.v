module bin2bcd (
    input [11:0] bin,
    output [15:0] bcd
);
    wire [27:0] bcd_data0;
    // 20 bits: 12 bits of bcd followed by the 8-bit input
    assign bcd_data0 = {16'h0, bin};
    wire [27:0] bcd_data1, bcd_data2, bcd_data3, bcd_data4;
    wire [27:0] bcd_data5, bcd_data6, bcd_data7, bcd_data8;
    wire [27:0] bcd_data9, bcd_data10, bcd_data11, bcd_data12;

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

    bcd_modify bcd_modify_inst9 (
        .data_in (bcd_data8),
        .data_out (bcd_data9)
    );

    bcd_modify bcd_modify_inst10 (
        .data_in (bcd_data9),
        .data_out (bcd_data10)
    );

    bcd_modify bcd_modify_inst11 (
        .data_in (bcd_data10),
        .data_out (bcd_data11)
    );

    bcd_modify bcd_modify_inst12 (
        .data_in (bcd_data11),
        .data_out (bcd_data12)
    );

    assign bcd = bcd_data12[27:12];
endmodule