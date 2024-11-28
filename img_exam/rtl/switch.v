module switch
(
	//被比较交换的数输入
	input			[7:0]	d0,		//参与交互的第1个数
	input			[7:0]	d1,		//参与交互的第2个数
	//输出交互后的数据
	output			[7:0]	max,	//交互比较后的最大的数据
	output			[7:0]	min		//交互比较后的最小的数据
);
	assign max = (d0 >= d1) ? d0 : d1;
	assign min = (d0 <= d1) ? d0 : d1;	
endmodule