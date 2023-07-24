----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/05/04 17:46:40
-- Design Name: 
-- Module Name: Divisor_Frecuencia - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Divisor_Frecuencia is
 Port (clk,rst : in std_logic; 
       clk_out:out std_logic );
end Divisor_Frecuencia;
---como la frecuencia que tiene Basys3 es 100Mhz, lo dividimos en 100 unidades,la mitad para el nivel alto y otra mitad para nivel bajo
architecture Behavioral of Divisor_Frecuencia is
begin
    process(clk,rst)
    variable cont:integer:=0;
        begin
        if(rst='1')then
           cont:=0;
           clk_out<='0';
--- un reloj
        elsif rising_edge(clk)then
           cont:= cont +1;
           if cont = 100 then
              cont:=0;
           end if;
--- para los 50 primero ciclos, alimentamos a 1
           if cont < 50 then
              clk_out<='1';
           else 
              clk_out<='0';
           end if;
        end if;
     end process;


end Behavioral;
