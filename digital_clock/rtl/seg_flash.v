module seg_flash (
    input sys_clk,
    input sys_rst_n,
    input [7:0] bcd_input,
    input en_signal,
    output reg [7:0] bcd_output
);
    wire clk_out;
    reg flash;

    // Generate 1hz clock for LED segment control
    clk_div_1hz clk_div_1hz_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_out)
    );

    // Flashing segment
    always @(posedge clk_out or negedge sys_rst_n) begin
        if (~sys_rst_n)
            flash <= 1'b0;
        else 
            flash <= ~flash;
    end

    // BCD output based on the enable signal
    always @(posedge clk_out or negedge sys_rst_n) begin
        if (~sys_rst_n)
            bcd_output <= 8'd0;
        else if (en_signal)
            bcd_output <= flash ? bcd_input : 8'd0;
        else
            bcd_output <= bcd_input;
    end
endmodule