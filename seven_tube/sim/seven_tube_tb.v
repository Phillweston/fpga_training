`timescale 1ns/1ps

module seven_tube_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire [2:0] sel;
    wire [7:0] seg;

    seven_tube seven_tube_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .data_in(24'h012345),
        .sel(sel),
        .seg(seg)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;

        #200.1 sys_rst_n = 1'b1;
    end
endmodule