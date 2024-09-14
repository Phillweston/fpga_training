module key_toggle (
    input sys_clk,
    input sys_rst_n,
    input key_pulse,
    output reg key_press
);
    reg toggle;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            key_press <= 1'b0;
            toggle <= 1'b0;
        end else begin
            if (key_pulse) begin
                toggle <= ~toggle;
                key_press <= toggle;
            end else begin
                key_press <= 1'b0;
            end
        end
    end
endmodule