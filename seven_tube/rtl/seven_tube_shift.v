// Display "HELLO" on the seven tube with shift character by character in 0.5 second interval.
module seven_tube_shift (
    input sys_clk,
    input sys_rst_n,
    //input [23:0] data_in,
    output [2:0] sel,
    output [7:0] seg
);
    wire clk_1khz;
    wire [23:0] data;

	// seven_tube_debug seven_tube_debug_inst (
	// 	.source (data), // sources.source
	// 	.probe  ()   //  probes.probe
	// );

    shift_data shift_data_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .data_out(data)
    );

    clk_div_2khz clk_div_2khz_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_out(clk_1khz)
    );

    seg_ctrl_shift seg_ctrl_shift_inst (
        .clk_1khz(clk_1khz),
        .sys_rst_n(sys_rst_n),
        .data_in(data),
        .sel(sel),
        .seg(seg)
    );
endmodule