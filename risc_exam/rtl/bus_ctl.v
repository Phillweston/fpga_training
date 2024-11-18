/*
功能： 由于CPU内部的地址有指令地址，还有操作地址，所以地址总线我们需要控制输出，
       有时需要将结算结果写入外部存储空间，因此我们需要通过三态控制数据总线
       本模块主要针对CPU总线的数据总线控制，地址总线控制
*/
module bus_ctl (
    // CPU地址总线选择有关
    output [12:0] bus_addr,    // CPU地址总线
    input         a_sel,       /* A_sel 选择
                                   0 指令地址
                                   1 操作地址 */
    input [12:0]  pc,          // 指令地址
    input [12:0]  ir,          // 操作地址
    // CPU数据总线选择有关
    input         bus_data_link, /* Bus_data_link 选择
                                    1 写数据
                                    0 读数据 */
    inout [7:0]   bus_data,    // CPU数据总线
    input [7:0]   out_acc      // 累加器
);

	// 数据总线控制
	assign bus_data = bus_data_link ? out_acc : 8'hzz;

	// 地址总线控制
	assign bus_addr = (~a_sel) ? pc : ir;

endmodule