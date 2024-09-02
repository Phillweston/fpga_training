module dcfifo_rd_ctrl (
    input dcfifo_rd_clk,
    input sys_rst_n,
    input rd_empty,
    input rd_full,
    output reg rd_req,
    output led1
);
    reg state;
    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    always @(posedge dcfifo_rd_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= s0;
            rd_req <= 1'b0;
        end else begin
            case (state)
                s0: begin
                    if (rd_full) begin
                        rd_req <= 1'b1;     // Start read request when FIFO is full
                        state <= s1;
                    end else
                        state <= s0;
                end
                s1: begin
                    if (rd_empty) begin
                        rd_req <= 1'b0;     // No read request when FIFO is empty
                        state <= s0;
                    end else begin
                        rd_req <= 1'b1;     // Continue read request when FIFO is not empty
                        state <= s1;
                    end
                end
                default: begin
                    state <= s0;
                    rd_req <= 1'b0;
                end
            endcase
        end
    end

    assign led1 = rd_empty ? 1'b0 : 1'b1;
endmodule