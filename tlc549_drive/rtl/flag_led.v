module flag_led (
    input sys_clk,
    input sys_rst_n,
    input flag,
    output reg led
);
    // Parameter for 1 second delay
    parameter CLOCK_FREQ = 50_000_000; // Example: 50 MHz clock frequency
    parameter ONE_SECOND = CLOCK_FREQ; // Number of clock cycles in 1 second

    reg [31:0] counter;
    reg flag_latched;

    // Always block for flag latching, counter initialization, and LED control
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            flag_latched <= 1'b0;
            counter <= 32'b0;
            led <= 1'b0;
        end else begin
            if (flag && ~flag_latched) begin
                // Start the counter when flag is high and not latched
                counter <= ONE_SECOND;
                flag_latched <= 1'b1;
                led <= 1'b1;
            end else if (counter > 0) begin
                // Decrement the counter
                counter <= counter - 1;
                if (counter == 1) begin
                    // Turn off the LED when the counter reaches 0
                    led <= 1'b0;
                    flag_latched <= 1'b0;
                end
            end
        end
    end
endmodule