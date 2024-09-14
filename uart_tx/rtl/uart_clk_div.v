module uart_clk_div (
    input sys_clk,
    input sys_rst_n,
    output reg uart_clk
);
    parameter BAUD_RATE = 9600;
    parameter SYS_CLK_FREQ = 50_000_000;
    localparam OVERSAMPLE_RATE = 16;
    localparam CLK_DIV = SYS_CLK_FREQ / (BAUD_RATE * OVERSAMPLE_RATE);

    reg [15:0] clk_cnt;

    // Generate the baudrate clock
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            clk_cnt <= 0;
            uart_clk <= 0;
        end else if (clk_cnt == CLK_DIV / 2 - 1) begin
            clk_cnt <= 0;
            uart_clk <= ~uart_clk;
        end else begin
            clk_cnt <= clk_cnt + 1;
        end
    end
endmodule