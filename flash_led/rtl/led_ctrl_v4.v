module led_ctrl_v4 (
    input clk_2hz,
    input sys_rst_n,
    output reg [3:0] led
);
reg [1:0] current_state;
reg [1:0] next_state;

parameter s0 = 2'd0;
parameter s1 = 2'd1;
parameter s2 = 2'd2;
parameter s3 = 2'd3;

always @(posedge clk_2hz or negedge sys_rst_n) begin : FSM_3S_1_CN_Moore
    if (~sys_rst_n)
        current_state <= s0;
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        s0: begin
            next_state = s1;
        end
        s1: begin
            next_state = s2;
        end
        s2: begin
            next_state = s3;
        end
        s3: begin
            next_state = s0;
        end
        default: begin
            next_state = s1;
        end
        
    endcase
end

always @(posedge clk_2hz or negedge sys_rst_n) begin
    case (current_state)
        s0: begin
            led = 4'b1110;
        end
        s1: begin
            led = {led[2:0], led[3]};
        end
        s2: begin
            led = {led[2:0], led[3]};
        end
        s3: begin
            led = {led[2:0], led[3]};
        end
        default: begin
            led = 4'b1110;
        end
    endcase
end

endmodule