library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Top_Sensor is
Port (clk,rst :in std_logic;
    Leds_Out:out std_logic_vector(7 downto 0);
    PulsoEcho: in std_logic;
    Trig:out std_logic;
    LedS: out std_logic);
end Top_Sensor;

architecture Behavioral of Top_Sensor is
component Sensor_Ultrasonido is
Port (Led_Output:out std_logic_vector(7 downto 0);
      Trigger:out std_logic;
      Echo: in std_logic;
      Clk:in std_logic; 
      Led: out std_logic);
end component;

component Divisor_Frecuencia is
 Port (clk,rst : in std_logic; 
       clk_out:out std_logic );
end component;

signal xclk: std_logic;
begin
mod1: Divisor_Frecuencia port map(
     clk => clk,
     rst => rst,
     clk_out=> xclk
);
mod2: Sensor_Ultrasonido port map(
         Led_OutPut => Leds_Out,
          Trigger => Trig,
          Echo => PulsoEcho,
          Led => LedS,
          clk => xclk
);

end Behavioral;
