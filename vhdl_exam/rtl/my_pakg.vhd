library  IEEE;
USE 	 IEEE.STD_LOGIC_1164.ALL; 

package   my_pakg   is
type  mem  is  array   (7  downto  0)  of   std_logic_vector  (255   downto   0);--定义数组
type  STATE_CODE  IS   (S0,S1,S2,S3);
end  my_pakg; 