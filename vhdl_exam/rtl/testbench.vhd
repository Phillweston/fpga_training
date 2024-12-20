library  	IEEE;
USE 	 	IEEE.STD_LOGIC_1164.ALL; 
entity  testbench  is
end testbench;
architecture arch_testbench  of testbench  is
component  my_exam   
		 port 
		 (
			clk,rst_n			:in  	 std_logic;--定义时钟和复位，为单比特逻辑类型
			out_tmp				:out	 std_logic_vector (3 downto  0);	
			my_when				:out   	 std_logic_vector (3 downto  0);
			my_with				:out	 std_logic_vector (3 downto  0)	 
		 );

end component;
signal			clk				:std_logic:='0';
signal			rst_n			:std_logic:='0';--定义时钟和复位，为单比特逻辑类型
signal			out_tmp			:std_logic_vector (3 downto  0);	
signal			my_when			:std_logic_vector (3 downto  0);
signal			my_with			:std_logic_vector (3 downto  0);	

begin
process 
begin
rst_n <='0';
wait for  13 ns;
rst_n <='1';
wait;
end process; 
clk <=  not  clk after   2 ns;
my_exam_ins:my_exam
port  map
(
		clk  => clk,	
		rst_n=>rst_n,
		out_tmp=>out_tmp,
		my_when=>my_when,
		my_with=>my_with
);

end  arch_testbench;