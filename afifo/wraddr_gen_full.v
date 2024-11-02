module wraddr_gen_full (
    // 系统相关
    input rst_n,
    // Fifo写操作相关
    input wr_clk,    // 写时钟
    input wr_en,     // 写使能
    // 输出写地址与状态
    output [3:0] wraddr, // 存储块写地址
    output reg full,     // 当full==1表示满
    // 存储块状态判断有关地址
    output [4:0] wraddr_e, // 扩位后写地址
    input [4:0] rdaddr_e   // 扩位后读地址
);

    // 写地址计算
    reg [4:0] wraddr_e_tmp;
    assign wraddr = wraddr_e_tmp[3:0];
    assign wraddr_e = wraddr_e_tmp[4:0];

    wire [4:0] wraddr_e_tmp_ns;
    assign wraddr_e_tmp_ns = wraddr_e_tmp + (wr_en & (~full));

    always @(posedge wr_clk or negedge rst_n) begin
        if (~rst_n)
            wraddr_e_tmp <= 5'd0;
        else
            wraddr_e_tmp <= wraddr_e_tmp_ns;
    end

    // 判断写状态
    reg [4:0] rdaddr_e1, rdaddr_e2;

    always @(posedge wr_clk) begin
        rdaddr_e1 <= rdaddr_e;
        rdaddr_e2 <= rdaddr_e1;
    end

    always @(posedge wr_clk or negedge rst_n) begin
        if (~rst_n)
            full <= 1'b0;
        else if (rdaddr_e2 == {~wraddr_e_tmp_ns[4], wraddr_e_tmp_ns[3:0]})
            full <= 1'b1;
        else
            full <= 1'b0;
    end

endmodule