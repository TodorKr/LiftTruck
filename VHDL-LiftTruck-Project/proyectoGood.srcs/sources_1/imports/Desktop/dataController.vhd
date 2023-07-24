library IEEE;
use IEEE.std_logic_1164.ALL;

entity dataController is
    Port (datos: in std_logic_VECTOR (2 downto 0); clk, reset: in std_logic; speedVcc, speedGnd, dirVcc, dirGnd, shovelVcc, shovelSignal, shovelGnd: out std_logic);
end dataController;

architecture Behavioral of dataController is
component directionMotor IS
PORT (entrada: IN std_logic_VECTOR(2 DOWNTO 0); direcVcc, direcGnd: OUT std_logic);
END component;

component speedMotor IS
PORT (entrada: IN std_logic_VECTOR(2 DOWNTO 0); speedVcc, speedGnd: OUT std_logic);
END component;

component Top_shovel IS
PORT (
entrada: IN std_logic_VECTOR(1 DOWNTO 0);
clock: in std_logic;
shovVcc, shovGnd, shovSignal: OUT std_logic);
END component;

component Top_Sensor is
Port (clk,rst :in std_logic;
    --Leds_Out:out std_logic_vector(7 downto 0);
    PulsoEcho: in std_logic;
    --Trig:out std_logic;
    LedS: out std_logic);
end component;

signal mode, obstaculo, cambiomodo: std_logic;
signal inVel, inDir: std_logic_vector(2 downto 0);
signal inShov: std_logic_vector(1 downto 0);

begin
    --SE INTERCONECTAN LOS COMPONENTES CON LOS PUERTOS CORRESPONDIENTES DE ENTRADA Y SALIDA
    velocidad: speedMotor port map (entrada => inVel, speedVcc => speedVcc, speedGnd => speedGnd);
    direccion: directionMotor port map (entrada => inDir, direcVcc => dirVcc, direcGnd => dirGnd);
    pala: Top_shovel port map (entrada => inShov,clock => clk, shovVcc => shovelVcc, shovSignal => shovelSignal, shovGnd => shovelGnd);
    sensor: Top_Sensor port map (clk => clk, rst => reset, PulsoEcho => '0', ledS => obstaculo);
    
    --CAMBIO DE MODO: MOVIMIENTO o CARGA
    cambiomodo <= '1' when datos = "101" OR datos = "110" ELSE '0';
    process (cambiomodo) 
    begin
            if (rising_edge(cambiomodo)) then    --sometimes you need to include a package for rising_edge, you can use CLK'EVENT AND CLK = '1' instead
                if (datos = "101") then
                    mode <= '1';
                elsif (datos = "110") then mode <= '0';
                end if;
            end if;
    end process;    
    
    
    --ACTIVACION/DESACTIVACION DE MOTORES
    
    inVel <= datos WHEN (datos = "111" OR datos = "010" OR datos = "100") AND (obstaculo = '0' OR datos /= "111" OR mode = '1'); 
    -- ACTUALIZAR MOTOR DE VELOCIDAD CON SUS RESPECTIVAS SECUENCIAS Y ADEMAS TENIENDO EN CUENTA QUE ESTANDO EN MODO MOVIMIENTO NO HA DE HABER OBSTÁCULOS
    
    inDir <= datos WHEN (datos = "001" OR datos = "011") AND (mode = '0');
    -- ACTUALIZAR MOTOR DE DIRECCION CON LAS RESPECITVAS SECUENCIAS SIEMPRE Y CUANDO ESTE EN MODO MOVIMIENTO
    
    inShov <= datos(1 downto 0) WHEN mode = '1' AND (datos = "001" OR datos = "011" OR datos = "100");
    -- ACTUALIZAR MOTOR DE PALA CON LA SECUENCIA DE ACTUALIZACION CORRESPONDIENTE SIEMPRE QUE ESTE EN MODO CARGA 
    
end Behavioral;
