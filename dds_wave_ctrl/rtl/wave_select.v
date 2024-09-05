module wave_select (
    input sys_clk,
    input sys_rst_n,
    input [1:0] type_cnt,
    input [7:0] q_sine,
    input [7:0] q_sawtooth,
    input [7:0] q_square,
    input [7:0] q_triangular,
    output reg [7:0] q
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            q <= q_sine;
        end else begin
            case (type_cnt)
                2'b00: q <= q_sine;
                2'b01: q <= q_sawtooth;
                2'b10: q <= q_square;
                2'b11: q <= q_triangular;
            endcase
        end
    end
endmodule