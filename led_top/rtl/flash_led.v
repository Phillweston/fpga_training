module flash_led (
    input clk_1hz_half,
    input sys_rst_n,
    output reg led
);
    always @(posedge clk_1hz_half or negedge sys_rst_n) begin
        if (~sys_rst_n)
            led <= 1'b0;
        else
            led <= ~led;
    end
endmodule