module uart_rx_issp (
    input sys_clk,
    input sys_rst_n,
    input rxd
);
    wire locked;
    wire uart_clk;

    reg [7:0] temp_data;         // register the received data
    wire [7:0] rec_data;         // received data
    wire rec_flag;               // received data flag

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (uart_clk),
        .locked (locked)
	);

    uart_rx uart_rx_inst (
        .uart_clk (uart_clk),             // 16*baud
        .sys_rst_n (locked),
        .rxd (rxd),
        .rec_data (rec_data),  // received data
        .rec_flag (rec_flag)         // received data flag
    );

	signal_probe u0 (
		.source (), // sources.source
		.probe (rec_data)   //  probes.probe
	);

    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            temp_data <= 8'h0;
        else if (rec_flag)
            temp_data <= rec_data;
        else
            temp_data <= temp_data;
    end
endmodule