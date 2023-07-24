library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY speedMotor IS
PORT (entrada: IN std_logic_vector(2 DOWNTO 0); speedVcc, speedGnd: OUT std_logic);
END ENTITY;

ARCHITECTURE speedFunction OF speedMotor IS
BEGIN 
        speedVcc <= '1' WHEN entrada = "111" ELSE '0'; --COMBINACION DE ACTIVACION DE VCC(MOVIMIENTO DIRECTO)
        speedGnd <= '1' WHEN entrada = "010" ELSE '0'; --COMBINACION DE ACTIVACION DE GND(MOVIMIENTO INVERSO)
END speedFunction;