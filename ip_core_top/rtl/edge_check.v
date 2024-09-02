module edge_check (
    input						sys_clk,
    input						sys_rst_n,
    input						signal,					//待检测得跳变信号
    
    output						pos_edge,				//检测跳变信号上升沿标志
    output						neg_edge				//检测跳变信号下降沿标志
);
    //1级D触发器
    reg						q1;

    always @ (posedge sys_clk, negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0)
            q1 <= 1'b0;
        else
            q1 <= signal;
    end
    
    //2级D触发器
    reg						q2;

    always @ (posedge sys_clk, negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0)
            q2 <= 1'b0;
        else
            q2 <= q1;
    end

    assign pos_edge = ~q2 & q1;				//上升沿标志
    assign neg_edge = ~q1 & q2;				//下降沿标志

endmodule
