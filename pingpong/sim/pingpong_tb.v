`timescale 1ns/1ps

module pingpong_tb;
    reg sys_clk;
    reg sys_rst_n;

    wire [7:0] ram1_rd_data;
    wire [7:0] ram2_rd_data;

    pingpong_top pingpong_top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .ram1_rd_data (ram1_rd_data),
        .ram2_rd_data (ram2_rd_data)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_clk <= 1'b1;
        sys_rst_n <= 1'b0;
        #200.1
        sys_rst_n <= 1'b1;
    end
endmodule