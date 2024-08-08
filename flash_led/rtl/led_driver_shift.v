module led_driver_shift (
    input sys_clk,
    input sys_rst_n,
    output reg [3:0] led
);
    wire clk_out;

    clk_div_2hz uut_clk_div_2hz (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_out(clk_out)
    );

    // LED flasher with 2Hz (using shift register)
    always @(posedge clk_out or negedge sys_rst_n) begin
        if (~sys_rst_n)
            led <= 4'b1110;
        else
            led <= {led[2:0], led[3]};
    end

endmodule