module clk_div_dec (
    input sys_clk,
    input sys_rst_n,
    output clk_out_dec
);
    wire clk_out1, clk_out2;
    reg clk_out3, clk_out4;
    wire clk_div_dec1;
    wire clk_div_dec2;

    clk_div_5 uut1 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_out1(clk_out1),
        .clk_out2(clk_out2),
        .clk_out(clk_div_dec1)
    );

    // D Flip-flop for clk_out1 and clk_out2
    // Note: Not recommend to combine the posedge and negedge in the same sensitivity list
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            clk_out3 <= 1'b0;
            clk_out4 <= 1'b0;
        end else begin
            clk_out3 <= clk_out1;
            clk_out4 <= clk_out2;
        end
    end

    assign clk_div_dec2 = clk_out3 | clk_out4;
    assign clk_out_dec = clk_div_dec1 ^ clk_div_dec2;

endmodule