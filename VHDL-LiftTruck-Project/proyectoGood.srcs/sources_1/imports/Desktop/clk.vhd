
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk is
    Port ( clock : out STD_LOGIC);
end clk;

architecture Behavioral of clk is
begin
    process
    begin
        clock <= '1'; WAIT FOR 10 ns;
        clock <= '0'; WAIT FOR 10 ns;
    end process;
end Behavioral;
