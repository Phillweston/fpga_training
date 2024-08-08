module three_state (
    input en,
    input sda_buff,
    output sda
);
    assign sda = (en == 1'b1) ? sda_buff : 1'bz;
endmodule