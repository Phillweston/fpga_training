//控制模块
module control (
	
	input	wire			clk,						//时钟
	input	wire			rst_n,					//复位按键低电平有效
	input	wire			wave_flag,				//控制选择波形按键
	input	wire			key_freq_add_flag,	//控制波形频率递增
	input	wire			key_freq_sub_flag,	//控制波形频率递减
	input	wire			key_a_flag,				//控制幅度按键
		
	output	reg		[1:0]	wave_sel,		//输出选择的波形
	output	reg		[19:0]	wave_freq,	//输出所对应波形的频率
	output	reg		[1:0]	wave_a			//输出所对应波形的幅度
	);

	parameter	Base_freq = 500;				//基础设置的频率为500HZ
	
	reg		[19:0]		sin_freq;			//正弦波形的频率
	reg		[19:0]		square_freq;		//方波的频率
	reg		[19:0]		tri_freq;			//三角波的频率
	reg		[19:0]		saw_freq;			//锯齿波的频率
	
	reg		[1:0]		sin_a;					//正弦波形的幅度	
	reg		[1:0]		square_a;				//方波的幅度
	reg		[1:0]		tri_a;					//三角波的幅度			
	reg		[1:0]		saw_a;					//锯齿波的幅度	
//-------波形选择按键按下，进行选取波形--------------------
	always @(posedge clk or negedge rst_n)
	begin
		if(rst_n==0) wave_sel<=0;
		else if(wave_flag==1) wave_sel<=wave_sel+1'b1;
			else wave_sel<=wave_sel; 
	
	end
//-------波形选择为正弦波时，如果按下频率递增的按键，会每次递增500HZ--------------	
//-------波形选择为正弦波时，如果按下频率递减的按键，会每次递减500HZ--------------
//-------波形选择为正弦波时，如果没按控制频率的按键，频率保持不变--------------	
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n == 0 ) 
			sin_freq <= 0;
		else 
			if ( wave_sel==2'b00 )
				if ( key_freq_add_flag==1 ) 
					sin_freq <= sin_freq + Base_freq[19:0];
				else	if ( key_freq_sub_flag==1 )
					sin_freq <= sin_freq - Base_freq[19:0];
						else	sin_freq <= sin_freq;
	end
//-------波形选择为正弦波时，如果按下控制幅度的按键，幅度递增加一--------------	
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n==0 )	
			sin_a <= 0;
		else 
			if ( wave_sel==2'b00 )	
				if ( key_a_flag==1 ) 
					sin_a <= sin_a+1'b1;
	end
//-------波形选择为方波时，如果按下频率递增的按键，会每次递增500HZ--------------	
//-------波形选择为方波时，如果按下频率递减的按键，会每次递减500HZ--------------
//-------波形选择为方波时，如果没按控制频率的按键，频率保持不变--------------	
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n == 0 ) 
			square_freq <= 0;
		else 
			if ( wave_sel==2'b01 )
				if ( key_freq_add_flag==1 ) 
					square_freq <= square_freq + Base_freq[19:0];
				else	if ( key_freq_sub_flag==1 )
					square_freq <= square_freq - Base_freq[19:0];
						else	square_freq <= square_freq;
	end
//-------波形选择为方波时，如果按下控制幅度的按键，幅度递增加一--------------		
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n==0 )	
			square_a <= 0;
		else 
			if ( wave_sel==2'b01 )	
				if ( key_a_flag==1 ) 
					square_a <= square_a+1;
	end
//-------波形选择为三角波时，如果按下频率递增的按键，会每次递增500HZ--------------	
//-------波形选择为三角波时，如果按下频率递减的按键，会每次递减500HZ--------------
//-------波形选择为三角波时，如果没按控制频率的按键，频率保持不变--------------		
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n == 0 ) 
			tri_freq <= 0;
		else 
			if ( wave_sel==2'b10 )
				if ( key_freq_add_flag==1 ) 
					tri_freq <= tri_freq + Base_freq[19:0];
				else	if ( key_freq_sub_flag==1 )
					tri_freq <= tri_freq - Base_freq[19:0];
						else	tri_freq <= tri_freq;
	end
//-------波形选择为三角波时，如果按下控制幅度的按键，幅度递增加一--------------			
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n==0 )	
			tri_a <= 0;
		else 
			if ( wave_sel==2'b10 )	
				if ( key_a_flag==1 ) 
					tri_a <= tri_a+1;
	end
//-------波形选择为锯齿波时，如果按下频率递增的按键，会每次递增500HZ--------------	
//-------波形选择为锯齿波时，如果按下频率递减的按键，会每次递减500HZ--------------
//-------波形选择为锯齿波时，如果没按控制频率的按键，频率保持不变--------------		
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n == 0 ) 
			saw_freq <= 0;
		else 
			if ( wave_sel==2'b11 )
				if ( key_freq_add_flag==1 ) 
					saw_freq <= saw_freq + Base_freq[19:0];
				else	if ( key_freq_sub_flag==1 )
					saw_freq <= saw_freq - Base_freq[19:0];
						else	saw_freq <= saw_freq;
	end
//-------波形选择为锯齿波时，如果按下控制幅度的按键，幅度递增加一--------------				
	always @( posedge clk or negedge rst_n ) begin
		if ( rst_n==0 )	
			saw_a <= 0;
		else 
			if ( wave_sel==2'b11 )	
				if ( key_a_flag==1 ) 
					saw_a <= saw_a+1;
	end
//-------波形选择为00时，波形频率选择正弦波对应的频率--------------	
//-------波形选择为01时，波形频率选择方波对应的频率--------------				
//-------波形选择为10时，波形频率选择三角波对应的频率--------------				
//-------波形选择为11时，波形频率选择锯齿波对应的频率--------------							
	always @ ( posedge clk or negedge rst_n ) begin
		if ( rst_n==0 )
			wave_freq <= 0;
		else 
			case ( wave_sel )
				2'b00	:	wave_freq <= sin_freq;
				2'b01	:	wave_freq <= square_freq;	
				2'b10	:	wave_freq <= tri_freq;
				2'b11	:	wave_freq <= saw_freq;
				default	:	wave_freq <= 0;
			endcase
	end
//-------波形选择为00时，波形幅度选择正弦波对应的幅度--------------	
//-------波形选择为01时，波形幅度选择方波对应的幅度--------------				
//-------波形选择为10时，波形幅度选择三角波对应的幅度--------------				
//-------波形选择为11时，波形幅度选择锯齿波对应的幅度--------------
	always @ ( posedge clk or negedge rst_n ) begin
		if ( rst_n==0 )
				wave_a <= 0;
			else 
				case ( wave_sel )
					2'b00	:	wave_a <= sin_a;
					2'b01	:	wave_a <= square_a;	
					2'b10	:	wave_a <= tri_a;
					2'b11	:	wave_a <= saw_a;
					default	:	wave_a <= 0;
				endcase
	end
	
endmodule 