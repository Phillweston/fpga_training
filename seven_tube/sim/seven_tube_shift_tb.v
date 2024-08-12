`timescale 1ns/1ps

module seven_tube_shift_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire [2:0] sel;
    wire [7:0] seg;

    defparam seven_tube_shift_inst.shift_data_inst.T1s_half = 2;
    defparam seven_tube_shift_inst.clk_div_2khz_inst.CNT_MAX = 50;

    seven_tube_shift seven_tube_shift_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
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