module data_gen (
    input clk_50m,
    input sys_rst_n,
    output reg data_en,
    output reg [7:0] data_in
);
    // Enable data generation
    always @(posedge clk_50m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_en <= 1'b0;
        else
            data_en <= 1'b1;
    end

    // Generate data from 0 to 199
    always @(posedge clk_50m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_in <= 8'd0;
        else if (data_in == 8'd199)     
            data_in <= 8'd0;
        else if (data_en)
            data_in <= data_in + 8'd1;
        else
            data_in <= data_in;
    end
endmodule