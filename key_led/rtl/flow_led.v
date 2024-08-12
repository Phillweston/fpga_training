module flow_led (
    input clk_1hz,
    input sys_rst_n,
    output reg [3:0] led  // Managing 4 LEDs
);
    reg [1:0] state;  // 2-bit state to select which LED is on

    always @(posedge clk_1hz or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            led <= 4'b1111;  // All LEDs off on reset
            state <= 2'b00;  // Start with the first LED
        end else begin
            case (state)
                2'b00: led <= 4'b1110;  // LED0 on
                2'b01: led <= 4'b1101;  // LED1 on
                2'b10: led <= 4'b1011;  // LED2 on
                2'b11: led <= 4'b0111;  // LED3 on
            endcase
            state <= state + 2'b01;  // Move to the next state
        end
    end
endmodule