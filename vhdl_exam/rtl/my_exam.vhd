library		work;
use			work.my_pakg.all;
library  	IEEE;
USE 	 	IEEE.STD_LOGIC_1164.ALL; 
--------------------����ʵ��--------------------------------------------------------------------------
entity   my_exam   is 
		 port 
		 (
			clk,rst_n			:in  	 std_logic;--����ʱ�Ӻ͸�λ��Ϊ�������߼�����
			out_tmp				:out	 std_logic_vector (3 downto  0);	
			my_when				:out   	 std_logic_vector (3 downto  0);
			my_with				:out	 std_logic_vector (3 downto  0)	 
		 );
end     my_exam;

--------------------�ṹ��--------------------------------------------------------------------------
architecture  arch_my_exam   of    my_exam    is
signal  	  state		:STATE_CODE;
signal		  cnt		:integer  	range    0  to   3;
begin
-----------------״̬������---------------------------------
process(rst_n,state,cnt,clk)
begin
		if  rst_n ='0' then
				cnt    <=   0;
				state  <=  S0;		
		
		elsif  clk'event  and  clk='1'  then
				
				CASE  state   is
						WHEN   S0   =>
							   if  cnt=3 then
									state  <=  S1;
									cnt<=0;
							   else 
									cnt <= cnt +1;
							   end if;
						WHEN   S1   =>
							   if  cnt=3 then
									state  <=  S2;
									cnt<=0;
							   else 
									cnt <= cnt +1;
							   end if;
						when  S2   =>
							   if  cnt=3 then
									state  <=  S3;
									cnt<=0;
							   else 
									cnt <= cnt +1;
							   end if;
						when  S3  =>
							   if  cnt=3 then
									state  <=  S0;
									cnt<=0;
							   else 
									cnt <= cnt +1;
							   end if;
						WHEN others =>
								state  <=  S0;
				
				END CASE;
		end if;
end  process;

--------------------------------------------------------״̬�����-------------------------------------
process(rst_n,state,clk)
variable  out_val :std_logic_vector (3 downto 0);
begin
		if  rst_n ='0' then
				out_val    :=   "0000";		
		elsif  clk'event  and  clk='1'  then
				case  state  is
						WHEN  S0  =>
								out_val := "0001";
						WHEN  S1  =>
								out_val := "0010";
						WHEN  S2  =>
								out_val := "0100";
						WHEN  S3  =>
								out_val := "1000";
						WHEN others =>
								out_val    :=   "0000";	
				END CASE;								
		end  if ;
		out_tmp <=  out_val;
end process;


---------------------------����ģ-------------------------------------------
my_when   <=  	"0001"  when  state =S0  else 
				"0010"  when  state =S1  else 
				"0100"  when  state =S2  else 
				"1000"  when  state =S3  else 
				"0000";
				
with 	   state  select   my_with <= 
		   "0001"    when  S0,
		   "0010"    when  S1,
		   "0100"    when  S2,
		   "1000"    when  S3,
		   "0000"    when  others;
		  
end         arch_my_exam;
