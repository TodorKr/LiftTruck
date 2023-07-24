library IEEE;
use IEEE.std_logic_1164.ALL;

ENTITY testCocheCompleto IS
END testCocheCompleto;

ARCHITECTURE testCC OF testCocheCompleto IS

COMPONENT interconnection IS
Port (dataIn, reset, clk: in std_logic; speedVcc, speedGnd, dirVcc, dirGnd, shovelVcc, shovelSignal, shovelGnd: out std_logic; data: out std_logic_vector(2 downto 0));
END COMPONENT;
component clk is
port (clock: out std_logic);
end component;

SIGNAL rel,busy, dataInS, resetS, echoS, speedVccS, dirVccS, shovelVccS, speedGndS, dirGndS, shovelGndS,shovelSignalS: std_logic;
signal ruina: std_logic_vector(2 downto 0);
BEGIN
  reloj: clk port map (clock => rel);
  i:interconnection PORT MAP (dataIn => dataInS, reset => resetS, clk => rel,
        speedVcc => speedVccS, dirVcc => dirVccS, shovelVcc => shovelVccS, speedGnd => speedGndS, dirGnd => dirGndS,
                            shovelGnd => shovelGndS, shovelSignal => shovelSignalS, data => ruina);
    dataInS <= '1' after 0 us, '0' after 204 us, '0' after 308 us, '1' after 412 us, '0' after 516 us, '1' after 620 us, '0' after 800 us, '0' after 904 us, '0' after 1008 us,'1' after 1112 us;
    resetS <= '1' after 0 us;
	echoS <= '0';
END testCC;
