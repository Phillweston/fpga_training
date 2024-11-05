module dds (
    // 系统相关
    input           clk,            // 系统时钟，默认50mhz
    input           rst_n,          // 系统复位，低电平有效
    // 人机交互控制
    input  [31:0]   fword,          // 控制dds输出波形的频率
    input  [10:0]   pword,          // 控制输出波形的相位
    input  [10:0]   ch1_en,         // 控制输出波形的采样率
    // 输出波形采样输出
    output [7:0]    data_ch1,       // 通道1采样数据
    output          flag_data_Ch1   // 当flag_data_Ch1==1表示data_ch1[7:0]有效
);

    reg [31:0] addr_vir;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            addr_vir <= 32'd0;
        else 
            addr_vir <= addr_vir + fword;
    end

    wire [10:0] addr_rom;
    assign addr_rom = addr_vir[31:21] + pword;

    rom rom_ins (
        .clk(clk),
        .addr(addr_rom),
        .data(data_ch1)
    );

    assign flag_data_Ch1 = ch1_en;

endmodule