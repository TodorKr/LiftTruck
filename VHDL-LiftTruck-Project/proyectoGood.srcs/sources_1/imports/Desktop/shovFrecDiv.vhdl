library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY shovFrecDiv IS
PORT (clk: IN std_logic; shovClk: OUT std_logic);
END shovFrecDiv;

ARCHITECTURE Behavioral OF shovFrecDiv IS
BEGIN
    process(clk)
    variable cont:integer:=0;
    constant div: integer := 1000000/2000; --50MHz a 2kHz
   -- constant divHalf: integer := 100000000/9600/2;
    begin
          if clk'EVENT AND clk ='1' then
            if cont = div then
                       cont:=0;
            elsif cont < div/2 then
                shovClk<='1';
            else 
                  shovClk<='0';
            end if;
          end if;
          cont:= cont +1;
     end process;
END Behavioral;