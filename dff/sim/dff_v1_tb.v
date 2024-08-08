`timescale 1ns/1ps
module dff_v1_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg d;
    wire q;

    dff_v1 dff_v1_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .d(d),
        .q(q)
    );

    initial sys_clk = 1'b0;
    always #10 sys_clk = ~sys_clk;

    // Simulate the D flip-flop
    initial begin
        sys_rst_n = 1'b0;
        d = 1'b0;
        #23
        sys_rst_n = 1'b1;
        #12
        d = 1'b1;
        #28
        d = 1'b0;
        #20
        d = 1'b1;
        #12
        d = 1'b0;
        #80
        $stop;
    end
endmodule