module dcfifo_wr_ctrl (
    input wr_clk,
    input sys_rst_n,
    input wr_empty,
    input wr_full,
    output reg wr_req,
    output reg [7:0] wr_data
);
    reg state;
    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    always @(posedge wr_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= s0;
            wr_req <= 1'b0;
            wr_data <= 8'h00;
        end else begin
            case (state)
                s0: begin
                    if (wr_empty) begin
                        wr_req <= 1'b1;
                        state <= s1;
                    end else
                        state <= s0;
                end
                s1: begin
                    if (wr_full) begin
                        wr_req <= 1'b0;
                        wr_data <= 8'h00;
                        state <= s0;
                    end else begin
                        state <= s1;
                        wr_req <= 1'b1;
                        wr_data <= wr_data + 8'h01;
                    end
                end
            endcase
        end
    end
endmodule