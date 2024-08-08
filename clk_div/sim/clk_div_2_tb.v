`timescale 1ns/1ps

module clk_div_2_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire clk_out;
    
    clk_div_3 uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_out(clk_out)
    );
    
    initial begin
        sys_clk = 1'b0;
        sys_rst_n = 1'b0;
        #20.1 sys_rst_n = 1'b1;
        #1000 $finish;
    end
    
    always begin
        #20 sys_clk = ~sys_clk;
    end
endmodule