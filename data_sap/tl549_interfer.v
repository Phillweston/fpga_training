module tl549_interfer (
    // 系统相关
    input           clk,            // 系统时钟，默认50mhz
    input           rst_n,          // 系统复位，低电平有效
    // TL549 ad芯片接口
    output  reg     scl,            // TL549接口同步时钟，最高1.1mhz
    output  reg     cs_n,           // TL549接口片选，最高1.1mhz
    input           sdi,            // TL549接口采样数据输入
    // 人机交互控制
    input           ch0_en,         // 当ch0_en==1的时候开始采样
    // 输出采样数据
    output  reg [7:0] data_Ch0,     // 通道0采样数据输出
    output  reg     flag_data_Ch0   // 当flag_data_Ch0==1表示data_Ch0_[7:0]有效
);

    reg [9:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            cnt <= 10'd0;
        else
            case (cnt)
                0: if (ch0_en)
                        cnt <= cnt + 1'b1;
                895: cnt <= 10'd0;
                default: cnt <= cnt + 1'b1;
            endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            cs_n <= 1'b1;
        else
            case (cnt)
                0: if (ch0_en)
                        cs_n <= 1'b0;
                445: cs_n <= 1'b1;
                default: cs_n <= cs_n;
            endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            scl <= 1'b0;
        else
            case (cnt)
                (70 + (0 * 25)): scl <= 1'b1; // 第1个上升沿
                (70 + (1 * 25)): scl <= 1'b0;
                (70 + (2 * 25)): scl <= 1'b1; // 第2个上升沿
                (70 + (3 * 25)): scl <= 1'b0;
                (70 + (4 * 25)): scl <= 1'b1; // 第3个上升沿
                (70 + (5 * 25)): scl <= 1'b0;
                (70 + (6 * 25)): scl <= 1'b1; // 第4个上升沿
                (70 + (7 * 25)): scl <= 1'b0;
                (70 + (8 * 25)): scl <= 1'b1; // 第5个上升沿
                (70 + (9 * 25)): scl <= 1'b0;
                (70 + (10 * 25)): scl <= 1'b1; // 第6个上升沿
                (70 + (11 * 25)): scl <= 1'b0;
                (70 + (12 * 25)): scl <= 1'b1; // 第7个上升沿
                (70 + (13 * 25)): scl <= 1'b0;
                (70 + (14 * 25)): scl <= 1'b1; // 第8个上升沿
                (70 + (15 * 25)): scl <= 1'b0;
                default: scl <= scl;
            endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            data_Ch0 <= 8'd0;
        else
            case (cnt)
                (70 + (0 * 25)): data_Ch0[7] <= sdi; // 第1个上升沿
                (70 + (2 * 25)): data_Ch0[6] <= sdi; // 第2个上升沿
                (70 + (4 * 25)): data_Ch0[5] <= sdi; // 第3个上升沿
                (70 + (6 * 25)): data_Ch0[4] <= sdi; // 第4个上升沿
                (70 + (8 * 25)): data_Ch0[3] <= sdi; // 第5个上升沿
                (70 + (10 * 25)): data_Ch0[2] <= sdi; // 第6个上升沿
                (70 + (12 * 25)): data_Ch0[1] <= sdi; // 第7个上升沿
                (70 + (14 * 25)): data_Ch0[0] <= sdi; // 第8个上升沿
                default: data_Ch0 <= data_Ch0;
            endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            flag_data_Ch0 <= 1'b0;
        else if (cnt == (70 + (14 * 25)))
            flag_data_Ch0 <= 1'b1;
        else
            flag_data_Ch0 <= 1'b0;
    end

endmodule