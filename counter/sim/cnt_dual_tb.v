`timescale 1ns/1ps
module cnt_dual_inst_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire [3:0] cnt1;
    wire [3:0] cnt2;

    cnt_dual cnt_dual_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .cnt1(cnt1),
        .cnt2(cnt2)
    );

    initial sys_clk = 1'b0;
    always #10 sys_clk = ~sys_clk;

    // Simulate the D flip-flop
    initial begin
        sys_rst_n = 1'b0;
        #23
        sys_rst_n = 1'b1;
    end
endmodule