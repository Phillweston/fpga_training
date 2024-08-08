`timescale 1ns/1ps

module cmp_seq_tb;
    // Inputs
    reg sys_clk;
    reg sys_rst_n;
    // Outputs
    wire valid;

    cmp_seq uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .valid(valid)
    );
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        #23
        sys_rst_n = 1'b1;
        #1000
        $finish;
    end

    initial begin
        $monitor("sys_clk=%b, sys_rst_n=%b, valid=%b", sys_clk, sys_rst_n, valid);
    end
endmodule