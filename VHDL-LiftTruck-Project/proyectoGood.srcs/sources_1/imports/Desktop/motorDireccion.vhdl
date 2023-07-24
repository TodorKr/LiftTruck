library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY directionMotor IS
PORT (entrada: IN std_logic_VECTOR(2 DOWNTO 0); direcVcc, direcGnd: OUT std_logic);
END ENTITY;

ARCHITECTURE directionFunction OF directionMotor IS
BEGIN
        direcVcc <= '1' WHEN entrada = "001" ELSE '0'; --COMBINACION DE ACTIVACIÓN DE VCC(DERECHA)
        direcGnd <= '1' WHEN entrada = "011" ELSE '0'; --COMBINACION DE ACTIVACION DE GND(IZQUIERDA)
END directionFunction;