module dcfifo_wr_ctrl (
    input dcfifo_wr_clk,
    input sys_rst_n,
    input wr_empty,
    input wr_full,
    input [7:0] dpram_rd_data,
    input dpram_rd_en,
    output reg wr_req,
    output reg [7:0] dcfifo_wr_data,
    output led0
);
    reg state;
    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    always @(posedge dcfifo_wr_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= s0;
            wr_req <= 1'b0;
            dcfifo_wr_data <= 8'h00;
        end else begin
            case (state)
                s0: begin
                    if (wr_empty) begin
                        wr_req <= 1'b0;     // No write request when FIFO is empty
                        state <= s1;
                    end else
                        state <= s0;
                end
                s1: begin
                    if (wr_full) begin
                        wr_req <= dpram_rd_en;      // Start write request when FIFO is full and read request is active
                        dcfifo_wr_data <= 8'h00;
                        state <= s0;
                    end else begin
                        state <= s1;
                        wr_req <= dpram_rd_en;      // Continue write request when FIFO is not full and read request is active
                        dcfifo_wr_data <= dpram_rd_data;
                    end
                end
                default: begin
                    state <= s0;
                    wr_req <= 1'b0;
                    dcfifo_wr_data <= 8'h00;
                end
            endcase
        end
    end

    assign led0 = wr_full ? 1'b0 : 1'b1;
endmodule