`include "sdr_param.v"

module sdr_ref (
    // 系统相关
    input           clk,        /* 系统时钟，也是CK的时钟，默认50mhz
                                   目前sdr sdram的ck是频率瓶颈为200mhz */
    input           rst_n,      // 系统复位，低电平有效
    // 用户接口
    input           req_rf,     // 当req_rf==1的时候表示刷新请求
    output          done_rf,    // 当done_rf==1表示当前刷新完成
    // sdr sdram刷新操作相关接口信号
    output reg [4:0] cmd_rf     /* Cke =Cmd_rf[4]
                                   Cs_n= Cmd_rf[3]
                                   ras_n= Cmd_rf[2]
                                   cas_n= Cmd_rf[1]
                                   we_n= Cmd_rf[0] */
);

    localparam IDLE = 1'b0,
               RF_SANT = 1'b1;

    reg state;
    reg [2:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 3'd0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (req_rf)
                        state <= RF_SANT;
                RF_SANT:
                    if (cnt == `TRFC) begin
                        state <= IDLE;
                        cnt <= 3'd0;
                    end else begin
                        cnt <= cnt + 1'b1;
                    end
            endcase
        end
    end

    ////////////////////////////刷新操作//////////////////////////////////////////////////
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            cmd_rf <= `CMD_INIT;
        else if ((state == RF_SANT) & (cnt == 0))
            cmd_rf <= `CMD_RF;
        else
            cmd_rf <= `CMD_NOP;
    end

    assign done_rf = (state == RF_SANT) & (cnt == `TRFC);

endmodule