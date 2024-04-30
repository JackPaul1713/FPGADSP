----------------------------------------------------------------
-- name: channel ram
-- purp: ram to store samples from 8 channels
----------------------------------------------------------------

-------- libraries --------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.basicbuildingblocks_package.all;

-------- entity --------
entity channelRam is
    port(clk, resetn, write: in std_logic;
    	 readAddress, writeAddress: in std_logic_vector(2 downto 0);
    	 d: in std_logic_vector(15 downto 0);
    	 q: out std_logic_vector(15 downto 0));
end channelRam;

-------- architecture --------
architecture behavior of channelRam is
	signal s: std_logic_vector(7 downto 0);
	signal q0, q1, q2, q3, q4, q5, q6, q7: std_logic_vector(15 downto 0);
	--signal 
begin
	---- component mapping ----
	ch0: genericRegister
		generic map(16)
		port map(d => d, q => q0, load => s(0), clk => clk, resetn => resetn);
	ch1: genericRegister
		generic map(16)
		port map(d => d, q => q1, load => s(1), clk => clk, resetn => resetn);
	ch2: genericRegister
		generic map(16)
		port map(d => d, q => q2, load => s(2), clk => clk, resetn => resetn);
	ch3: genericRegister
		generic map(16)
		port map(d => d, q => q3, load => s(3), clk => clk, resetn => resetn);
	ch4: genericRegister
		generic map(16)
		port map(d => d, q => q4, load => s(4), clk => clk, resetn => resetn);
	ch5: genericRegister
		generic map(16)
		port map(d => d, q => q5, load => s(5), clk => clk, resetn => resetn);
	ch6: genericRegister
		generic map(16)
		port map(d => d, q => q6, load => s(6), clk => clk, resetn => resetn);
	ch7: genericRegister
		generic map(16)
		port map(d => d, q => q7, load => s(7), clk => clk, resetn => resetn);

	writer: decode3x8
		port map(sel => writeAddress, y => s, dataIn => write);
	reader: genericMux8x1
		generic map(16)
		port map(s => readAddress, 
			     f => q, 
			     y0 => q0, 
			     y1 => q1, 
			     y2 => q2, 
			     y3 => q3, 
			     y4 => q4, 
			     y5 => q5, 
			     y6 => q6, 
			     y7 => q7);
end ;

----------------------------------------------------------------
-- author: jack martin
-- date: 10/18/2023
----------------------------------------------------------------