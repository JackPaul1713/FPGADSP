--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2002
-- Purp: A generic 2:1 mux
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity genericMux2x1 is
    generic(N: integer := 4);
    port(y1,y0: in STD_LOGIC_VECTOR(N-1 downto 0);
	 s: in STD_LOGIC;
	 f: out STD_LOGIC_VECTOR(N-1 downto 0) );
end genericMux2x1;

architecture behavior of genericMux2x1 is
begin
	f <= y1 when s='1' else y0;
end behavior;
