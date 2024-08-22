`timescale 1ns/1ps

module beep_driver_v2_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_flag;

    wire beep;

    defparam beep_driver_v2_inst.MAX = 1000;
    defparam beep_driver_v2_inst.T = 4;

    beep_driver_v2 beep_driver_v2_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_flag (key_flag),
        .beep (beep)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        key_flag = 1'b0;
        #100;
        sys_rst_n = 1'b1;

        #100
        @(posedge sys_clk);
        key_flag = 1'b1;
        @(posedge sys_clk);
        key_flag = 1'b0;
    end
endmodule