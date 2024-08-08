module led_driver_fsm (
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

    // LED flasher with 2Hz (using FSM)
    reg [1:0] state, next_state;

    // Sequential block for state transition
    always @(posedge clk_out or negedge sys_rst_n) begin
        if (~sys_rst_n)
            state <= 2'b00;
        else
            state <= next_state;
    end

    // Combinational block for next state logic
    always @(*) begin
        case (state)
            2'b00: begin 
                next_state = 2'b01;
                led = 4'b1110;
            end
            2'b01: begin
                next_state = 2'b10;
                led = 4'b1101;
            end
            2'b10: begin
                next_state = 2'b11;
                led = 4'b1011;
            end
            2'b11: begin
                next_state = 2'b00;
                led = 4'b0111;
            end
            default: begin
                next_state = 2'b00;
                led = 4'b0000;
            end
        endcase
    end

endmodule