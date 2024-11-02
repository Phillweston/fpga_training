module mem_rw (
    // 写数据相关
    input           wr_clk,     // 写时钟
    input           wr_en,      // 写使能
    input   [7:0]   wrdata,     // 写数据
    input   [3:0]   wraddr,     // 写地址
    input           full,       // 写状态标志
    // 读数据相关    
    input           rd_clk,     // 读时钟
    input           rd_en,      // 读使能
    output  reg [7:0] rddata,   // 读数据
    input   [3:0]   rdaddr,     // 读地址
    input           empty       // 读状态标志
);

    reg [7:0] mem [15:0];

    // 写数据
    always @(posedge wr_clk) begin
        if (wr_en & (~full)) begin
            mem[wraddr] <= wrdata;
        end
    end

    // 读数据
    always @(posedge rd_clk) begin
        if (rd_en & (~empty)) begin
            rddata <= mem[rdaddr];
        end
    end

endmodule