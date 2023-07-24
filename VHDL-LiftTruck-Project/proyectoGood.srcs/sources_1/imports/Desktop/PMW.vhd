library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PWM is
Port ( entrada: IN std_logic_VECTOR(1 DOWNTO 0);
 clk: in std_logic;
 shovVcc, shovGnd, shovSignal: OUT std_logic);
end PWM;

architecture Behavioral of PWM is
signal count: integer :=39;      --contador del tiempo de periodo
signal duty: integer :=30; --El tiempo de trabajo de stop
signal entrada_Aux: std_logic_VECTOR(1 DOWNTO 0);
constant period :integer := 40;  --20 ms de PMW
begin
    shovVcc <= '1';
    shovGnd <= '0';
    counter:process(clk)    --dicho process controla e indica el tiempo que sea pasado en dicho periodo (de 20ms)
    begin
        if clk'event and clk = '1' then     --cuenta por cada flanco de subida
            if count = period-1  then count <= 0;
            else
                count <= count +1;
            end if;
        end if;
    end process counter;
    
    registro:process(count,entrada)     --es un proceso que almacena la ultima instruccion recibida
    variable aux: std_logic_VECTOR(1 DOWNTO 0);
    begin
        aux :=entrada;
        if count = 0 then
            entrada_Aux <=aux;
        end if;
        end process registro;
        
        
    translator:process(entrada_aux)     --traduce la se?al de la entrada en tiempo concreto de cada modo
    variable entrada_temp :std_logic_VECTOR(1 DOWNTO 0);
     begin
        CASE entrada is
           WHEN "01" => duty <= 10; --El servo gira en sentido antihorario,sube la pala
            WHEN "11" => duty <= 35;    --El servo gira en sentido horario,baja la pala
            WHEN others => duty <= 30;  --El servo queda parado
        END CASE;
      end process translator;
      
    control: process(count) --realiza asignacion de se?al al servo
    begin
        if  count < duty then
            shovSignal <= '1';
        else shovSignal <='0';
        end if;
      end process control;
end Behavioral;
