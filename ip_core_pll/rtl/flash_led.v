module flash_led (
    input sys_clk,
    input sys_rst_n,
    output reg led
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            led <= 1'b0;
        else
            led <= ~led;
    end
endmodule