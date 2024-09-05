module dds_wave_ctrl (
	input sys_clk,
	input sys_rst_n,
	input key_switch,
	input key_mode,
	input key_add,
	input key_sub,
	output [7:0] q
);
	wire [7:0] addr;
	wire clk_4khz;

    wire key_switch_filter;
	wire key_switch_filter_edge;
	wire key_mode_filter;
	wire key_mode_filter_edge;
	wire key_add_filter;
	wire key_add_filter_edge;
	wire key_sub_filter;
	wire key_sub_filter_edge;
    wire [1:0] type_cnt;
    wire [1:0] mode_cnt;

	wire [7:0] q_sine;
	wire [7:0] q_sawtooth;
	wire [7:0] q_square;
	wire [7:0] q_triangular;

	div_clk div_clk_inst (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.clk_out (clk_4khz)
	);

	addr_ctrl addr_ctrl_inst (
		.sys_clk (clk_4khz),
		.sys_rst_n (sys_rst_n),
		.mode_cnt (mode_cnt),
		.key_inc (key_add_filter_edge),
		.key_dec (key_sub_filter_edge),
		.addr (addr)
	);

	rom_sine rom_sine_inst (
		.address (addr),
		.clock (clk_4khz),
		.q (q_sine)
	);

	rom_sawtooth rom_sawtooth_inst (
		.address (addr),
		.clock (clk_4khz),
		.q (q_sawtooth)
	);

	rom_square rom_square_inst (
		.address (addr),
		.clock (clk_4khz),
		.q (q_square)
	);

	rom_triangular rom_triangular_inst (
		.address (addr),
		.clock (clk_4khz),
		.q (q_triangular)
	);

	// Select wave and output
	wave_select wave_select_inst (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.type_cnt (type_cnt),
		.q_sine (q_sine),
		.q_sawtooth (q_sawtooth),
		.q_square (q_square),
		.q_triangular (q_triangular),
		.q (q)
	);

	// Key switch filter
    key_filter key_filter_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_switch),
        .key_out (key_switch_filter)
    );

	// Key switch negedge detection
	edge_detection edge_detection_inst1 (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.signal (key_switch_filter),
		.pos_edge (),
		.neg_edge (key_switch_filter_edge)
	);

	// Key switch pulse counter
    pulse_cnt pulse_cnt_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pulse (key_switch_filter_edge),
        .pulse_cnt (type_cnt)
    );

	// Key mode filter
    key_filter key_filter_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_mode),
        .key_out (key_mode_filter)
    );

	// Key mode negedge detection
	edge_detection edge_detection_inst2 (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.signal (key_mode_filter),
		.pos_edge (),
		.neg_edge (key_mode_filter_edge)
	);

	// Key mode pulse counter
    pulse_cnt pulse_cnt_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pulse (key_mode_filter_edge),
        .pulse_cnt (mode_cnt)
    );

	// Key add filter
	key_filter key_filter_inst3 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_add),
        .key_out (key_add_filter)
    );

	// Key add negedge detection
	edge_detection edge_detection_inst3 (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.signal (key_add_filter),
		.pos_edge (),
		.neg_edge (key_add_filter_edge)
	);

	// Key sub filter
	key_filter key_filter_inst4 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_sub),
        .key_out (key_sub_filter)
    );

	// Key frequency sub negedge detection
	edge_detection edge_detection_inst4 (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.signal (key_sub_filter),
		.pos_edge (),
		.neg_edge (key_sub_filter_edge)
	);
endmodule