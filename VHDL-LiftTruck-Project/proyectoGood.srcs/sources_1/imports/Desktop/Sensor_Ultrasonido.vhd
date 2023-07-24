library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;

entity Sensor_Ultrasonido is
Port (Led_Output:out std_logic_vector(7 downto 0);
      Trigger:out std_logic;
      Echo: in std_logic;
      Clk:in std_logic; 
      Led: out std_logic);
end Sensor_Ultrasonido;

architecture Behavioral of Sensor_Ultrasonido is
signal echo_time:integer:=0;
begin
    process(clk)
        variable c1,c2:integer:=0;
        variable y:std_logic:='1';
    begin
        if rising_edge(clk)then
            if(c1=0)then
                Trigger<='1';
            elsif(c1=10)then  --si ha pasado 10us el nivel alto en trigger
                Trigger<='0';
                y:='1';
--               Led<='1';
            elsif(c1=1951)then  --si ha excedido del tiempo
                c1:=0;
                Trigger<='1';
--                Led<='0';
            end if;
            c1:=c1+1;
            
            if(Echo='1')then --mientra que no recibe se?al, va contando ciclo de reloj
                c2:=c2+1;
            elsif(Echo ='0' and y ='1')then
                echo_time<=c2;
                c2:=0;
                y:='0';
            end if;
            
            if(echo_time <1740) then --30cm se enciente la led de stop, o que se pare el coche
                Led<='1';
            else
                Led<='0';
            end if;
            Led_Output <=CONV_STD_LOGIC_VECTOR((echo_time/58),8); --calcular la distancia, y convertirlo en bits
            
        end if;
end process;
end Behavioral;
