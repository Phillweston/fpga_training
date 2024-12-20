//命令定义//////////////////////////////////////////////////////////
`define    CMD_INIT    5'b01xxx   	//禁止命令，禁止一切操作，这个命令解析不需要时间，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_NOP     5'b10111   	//空操作止命令，这个命令解析不需要时间，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_ACTIVE  5'b10011   	//激活命令，解析TRCD时间，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_READ    5'b10101   	//读命令，完整的操作解析 BL + TWR，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_WRITE   5'b10100   	//写命令，完整的操作解析 BL + CL，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_TM      5'b10110   	//禁止命令，这个命令解析不需要时间，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_PR      5'b10010   	//禁止命令，解析TRFC         {cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_RF      5'b10001   	//禁止命令，解析TRP，{cke,cs_n,ras_n,cas_n,we_n}
`define    CMD_LMR     5'b10000   	//禁止命令，解析TLMR  ，{cke,cs_n,ras_n,cas_n,we_n}
//////////////以MT48LC32M16A2为例/////////////////////////////////////////////////////
`define		CK_MYSELF  ((100000/20) -  1'b1)
`define		TRCD		1   		//15ns
`define		TRP			1			//20ns
`define		TRFC		4			//66ns
`define		TMRD		2			//2ck	
`define		TWR			2			//1ck+7ns
`define		BL			4			//默认BL=4
`define		CL			3			//默认CL=4		
