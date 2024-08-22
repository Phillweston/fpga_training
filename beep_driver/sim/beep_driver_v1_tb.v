`timescale 1ns/1ps

module beep_driver_v1_tb;
    reg sys_clk;
    reg sys_rst_n;

    wire beep;

    defparam beep_driver_v1_inst.MAX = 1000;
    defparam beep_driver_v1_inst.T = 4;

    beep_driver_v1 beep_driver_v1_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .beep (beep)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        #100;
        sys_rst_n = 1'b1;

    end
endmodule