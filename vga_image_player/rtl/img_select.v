module img_select (
    input sys_clk,
    input sys_rst_n,
    input [1:0] type_cnt,
    input [7:0] q1,
    input [7:0] q2,
    input [7:0] q3,
    output reg [7:0] q
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            q <= q1;
        end else begin
            case (type_cnt)
                2'b00: q <= q1;
                2'b01: q <= q2;
                2'b10: q <= q3;
                default: q <= q1;
            endcase
        end
    end
endmodule