module uart_rv #(
    parameter MULTY_BAND = 7
)(
    // 系统相关
    input clk,            // 系统时钟，默认50mhz
    input rst_n,          // 系统复位，低电平复位
    // Uart接口相关
    input rx,             // Uart接收
    // 人机交互接收速率控制
    input en_r,           // 接收速率控制
    // 接收数据输出
    output reg [7:0] rvdata,     // 接收数据
    output reg flag_rvdata       // 当flag_rvdata==1表示rvdata[7:0]有效
);

    reg [6:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            cnt <= 7'd0;
        else if (en_r)
            case (cnt)
                0: if (~rx) cnt <= cnt + 1'b1;
                ((MULTY_BAND * 11) - 1): cnt <= 7'd0;
                default: cnt <= cnt + 1'b1;
            endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            rvdata <= 8'd0;
        else if (en_r)
            case (cnt)
                ((2 * 7) - 4): rvdata[0] <= rx;
                ((3 * 7) - 4): rvdata[1] <= rx;
                ((4 * 7) - 4): rvdata[2] <= rx;
                ((5 * 7) - 4): rvdata[3] <= rx;
                ((6 * 7) - 4): rvdata[4] <= rx;
                ((7 * 7) - 4): rvdata[5] <= rx;
                ((8 * 7) - 4): rvdata[6] <= rx;
                ((9 * 7) - 4): rvdata[7] <= rx;
                default: rvdata <= rvdata;
            endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            flag_rvdata <= 1'b0;
        else if (en_r & (cnt == ((10 * 7) - 4)) & (~(rvdata[0] ^ rvdata[1] ^ rvdata[2] ^ rvdata[3] ^ rvdata[4] ^ rvdata[5] ^ rvdata[6] ^ rvdata[7] ^ rx)))
            flag_rvdata <= 1'b1;
        else
            flag_rvdata <= 1'b0;
    end

endmodule