library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY Top_shovel IS
PORT (
entrada: IN std_logic_VECTOR(1 DOWNTO 0);
clock: in std_logic;
shovVcc, shovGnd, shovSignal: OUT std_logic);
END ENTITY;

ARCHITECTURE shovelFunction OF Top_shovel IS


COMPONENT shovFrecDiv is        --divsor de frecuencia a 2kHZ
PORT (clk: IN std_logic; shovClk: OUT std_logic);
END COMPONENT;

COMPONENT PWM is        --pulse witdh module
Port ( entrada: IN std_logic_VECTOR(1 DOWNTO 0);
 clk: in std_logic;
 shovVcc, shovGnd, shovSignal: OUT std_logic);
END COMPONENT;

signal clock_shovel :std_logic;

BEGIN
    frecuency_divider : shovFrecDiv
        port map(clk => clock,
        shovClk=>clock_shovel);
    pulse: PWM
        port map(entrada =>entrada,clk=> clock_shovel,shovVcc=>shovVcc,shovGnd=>shovGnd,shovSignal=>shovSignal);
        
        
END shovelFunction;
