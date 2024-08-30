module scfifo_ctrl (
    input sys_clk,
    input sys_rst_n,
    input empty,
    input full,
    output reg wr_req,
    output reg [7:0] wr_data,
    output reg rd_req
);
    reg state;
    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= s0;
            wr_req <= 1'b0;
            wr_data <= 8'h00;
            rd_req <= 1'b0;
        end else begin
            case (state)
                s0: begin
                    if (empty) begin
                        wr_req <= 1'b1;
                        wr_data <= 8'h00;
                    end else if (full) begin
                        state <= s1;
                        wr_req <= 1'b0;
                        wr_data <= 8'h00;
                    end else begin
                        state <= s0;
                        wr_req <= 1'b1;
                        wr_data <= wr_data + 8'h01;
                    end
                end
                s1: begin
                    if (full) begin
                        rd_req <= 1'b1;
                    end else if (empty) begin
                        rd_req <= 1'b0;
                        state <= s0;
                    end
                end
                default: begin
                    state <= s0;
                    wr_req <= 1'b0;
                    wr_data <= 8'h00;
                    rd_req <= 1'b0;
                end
            endcase
        end
    end
endmodule