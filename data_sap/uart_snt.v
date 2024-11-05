module uart_snt (
    // 系统相关
    input           clk,    // 系统时钟，默认50mhz
    input           rst_n,  // 系统复位，低电平复位
    // Fifo读相关
    output          rd_en,  // FIFO读使能
    output          rd_clk, // FIFO读时钟
    input  [7:0]    rddata, // FIFO读数据
    input           empty,  // FIFO读状态
    // 人机控制相关
    input           en_t,   // 控制发送速率
    // Uart接口相关
    output reg      tx      // 发送信号
);

    reg [3:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            cnt <= 4'd0;
        else if (en_t)
            case (cnt)
                0       : if (~empty) cnt <= cnt + 1'b1;
                11      : cnt <= 4'd0;
                default : cnt <= cnt + 1'b1;
            endcase
    end

    // FIFO读数据
    assign rd_clk = clk;
    assign rd_en = (cnt == 0) & (~empty) & en_t;

    // uart发送
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            tx <= 1'b1;
        else if (en_t)
            case (cnt)
                0       : tx <= 1'b1;
                1       : tx <= 1'b0;
                2       : tx <= rddata[0];
                3       : tx <= rddata[1];
                4       : tx <= rddata[2];
                5       : tx <= rddata[3];
                6       : tx <= rddata[4];
                7       : tx <= rddata[5];
                8       : tx <= rddata[6];
                9       : tx <= rddata[7];
                10      : tx <= rddata[0] ^ rddata[1] ^ rddata[2] ^ rddata[3] ^ rddata[4] ^ rddata[5] ^ rddata[6] ^ rddata[7]; // even parity
                11      : tx <= 1'b1;
                default : tx <= 1'b1;
            endcase
    end

endmodule