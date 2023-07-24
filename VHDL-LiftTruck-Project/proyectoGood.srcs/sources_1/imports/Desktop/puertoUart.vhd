library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity interconnection is
Port (dataIn, reset, clk: in std_logic; speedVcc, speedGnd, dirVcc, dirGnd, shovelVcc, shovelSignal, shovelGnd: out std_logic);
end interconnection;


architecture Behavioral of interconnection is

component uart IS
	GENERIC(
		clk_freq	:	INTEGER		:= 1000000;	--frequency of system clock in Hertz
		baud_rate	:	INTEGER		:= 9600;		--data link baud rate in bits/second
		os_rate		:	INTEGER		:= 8;			--oversampling rate to find center of receive bits (in samples per baud period)
		d_width		:	INTEGER		:= 3; 			--data bus width
		parity		:	INTEGER		:= 0;				--0 for no parity, 1 for parity
		parity_eo	:	STD_LOGIC	:= '0');			--'0' for even, '1' for odd parity
	PORT(
		clk		:	IN		STD_LOGIC;										--system clock
		reset_n	:	IN		STD_LOGIC;										--ascynchronous reset
		tx_ena	:	IN		STD_LOGIC;										--initiate transmission
		tx_data	:	IN		STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
		rx		:	IN		STD_LOGIC;										--receive pin
		rx_busy	:	OUT	STD_LOGIC;										--data reception in progress
		rx_error:	OUT	STD_LOGIC;										--start, parity, or stop bit error detected
		rx_data	:	OUT	STD_LOGIC_VECTOR(d_width-1 DOWNTO 0)	--data received
		--tx_busy	:	OUT	STD_LOGIC;  									--transmission in progress
		--tx		:	OUT	STD_LOGIC);										--transmit pin
		);
END component;


component dataController is
    Port (datos: in STD_LOGIC_VECTOR (2 downto 0); clk, reset: in std_logic; speedVcc, speedGnd, dirVcc, dirGnd, shovelVcc, shovelSignal, shovelGnd: out std_logic);
end component;

component Divisor_Frecuencia is
 Port (clk,rst : in std_logic; 
       clk_out:out std_logic );
end component;


signal ocupado, txb, txp, clkDiv: std_logic;
signal rx_data, datos, datostransm: std_logic_vector(2 downto 0);

begin
    datosUart: uart port map (clk => clkDiv, reset_n => '1', tx_ena => '0', tx_data => "000", rx => dataIn, rx_busy => ocupado, rx_data => rx_data);
    controladorDatos: dataController port map (datos => datos, clk => clkDiv, reset => reset, speedVcc => speedVcc, speedGnd => speedGnd, dirVcc => dirVcc, dirGnd => dirGnd, shovelVcc => shovelVcc,
                                               shovelSignal => shovelSignal, shovelGnd => shovelGnd);
    div_1Mhz: Divisor_Frecuencia port map (clk => clk, rst => '0', clk_out => clkDiv);
    
    --ENVIAR DATOS VALIDOS SOLO CUANDO EL RECEPTOR NO ESTE OCUPADO
    datos <= rx_data when ocupado = '0';
    
end Behavioral;
