`timescale 1ns/1ps

module dpram_v3_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire [7:0] rd_data;

    dpram_v3_top dpram_v3_top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rd_data (rd_data)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        #200.1
        sys_rst_n = 1'b1;
    end
endmodule