`timescale 1ns/1ps

module check_bin_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg in_flow;
    wire flag;

    check_bin check_bin_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .in_flow(in_flow),
        .flag(flag)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        in_flow = 1'b0;

        #200.1 sys_rst_n = 1'b1;
        #100
        repeat(1000) begin
            #20
            in_flow = {$random} % 2;
        end
    end
endmodule