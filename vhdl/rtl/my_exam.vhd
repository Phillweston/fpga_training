library work;
use work.my_pakg.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--------------------定义实体--------------------
entity my_exam is
    port (
        clk, rst_n : in std_logic; -- 定义时钟和复位，为单比特逻辑类型
        out_tmp    : out std_logic_vector(3 downto 0);
        my_when    : out std_logic_vector(3 downto 0);
        my_with    : out std_logic_vector(3 downto 0)
    );
end my_exam;

--------------------结构体--------------------
architecture arch_my_exam of my_exam is
    signal state : STATE_CODE;
    signal cnt   : integer range 0 to 3;
begin
    -----------------状态机定义-----------------
    process (rst_n, state, cnt, clk)
    begin
        if rst_n = '0' then
            cnt <= 0;
            state <= S0;
        elsif clk'event and clk = '1' then
            case state is
                when S0 =>
                    if cnt = 3 then
                        state <= S1;
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                    end if;
                when S1 =>
                    if cnt = 3 then
                        state <= S2;
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                    end if;
                when S2 =>
                    if cnt = 3 then
                        state <= S3;
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                    end if;
                when S3 =>
                    if cnt = 3 then
                        state <= S0;
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                    end if;
                when others =>
                    state <= S0;
            end case;
        end if;
    end process;

    -----------------状态机输出-----------------
    process (rst_n, state, clk)
        variable out_val : std_logic_vector(3 downto 0);
    begin
        if rst_n = '0' then
            out_val := "0000";
        elsif clk'event and clk = '1' then
            case state is
                when S0 =>
                    out_val := "0001";
                when S1 =>
                    out_val := "0010";
                when S2 =>
                    out_val := "0100";
                when S3 =>
                    out_val := "1000";
                when others =>
                    out_val := "0000";
            end case;
        end if;
        out_tmp <= out_val;
    end process;

    -----------------流建模-----------------
    my_when <= "0001" when state = S0 else
               "0010" when state = S1 else
               "0100" when state = S2 else
               "1000" when state = S3 else
               "0000";

    with state select my_with <=
        "0001" when S0,
        "0010" when S1,
        "0100" when S2,
        "1000" when S3,
        "0000" when others;

end arch_my_exam;
