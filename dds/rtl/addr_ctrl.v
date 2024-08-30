module addr_ctrl (
    input sys_clk,
    input sys_rst_n,
    output [7:0] addr
);
    reg [23:0] addr_temp;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            addr_temp <= 24'd0;
        end else if (addr < 2 ** 16 - 1) begin
            // N=24		1KHZ=50MHZ / 2 ^ 24 * B		B = 335.54432	
            addr_temp <= addr_temp + 24'd336;       // B=335.54432
        end else begin
            addr_temp <= 24'd0;
        end
    end

    assign addr = addr_temp[23:16];      // Retrieve the upper 8 bits of the address
endmodule