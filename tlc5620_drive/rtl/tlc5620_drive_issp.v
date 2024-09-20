module tlc5620_drive_issp (
    input sys_clk,
    input sys_rst_n,
    output tlc5620_clk,         // DAC serial clock line
    output tlc5620_data,        // DAC serial data line
    output tlc5620_load,        // DAC load line
    output tlc5620_ldac         // load DAC
);
    wire [10:0] data;

    my_issp u0 (
        .source (data),
        .probe ()
    );

    tlc5620_drive tlc5620_drive_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .cmd_code (data),          // 11-bit command code (A1 A0 RNG D7 D6 D5 D4 D3 D2 D1 D0)
        .tlc5620_clk (tlc5620_clk),         // DAC serial clock line
        .tlc5620_data (tlc5620_data),        // DAC serial data line
        .tlc5620_load (tlc5620_load),        // DAC load line
        .tlc5620_ldac (tlc5620_ldac)         // load DAC
    );
endmodule