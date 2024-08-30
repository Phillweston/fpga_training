`timescale 1ns/1ps

module dds_tb;
    reg clock;
    reg sys_rst_n;

    wire [7:0] q;
    defparam dds_inst.div_clk_inst.CNT_MAX = 5;

    dds dds_inst (
        .sys_clk (clock),
        .sys_rst_n (sys_rst_n),
        .q (q)
    );

    initial clock = 1'b1;

    always #10 clock = ~clock;

    initial begin
        sys_rst_n = 0;

        #10 sys_rst_n = 1;
    end
endmodule