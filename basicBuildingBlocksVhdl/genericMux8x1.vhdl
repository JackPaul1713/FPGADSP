--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2002
-- Purp: A generic 8:1 mux
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity genericMux8x1 is
    generic(N: integer := 8);
    port(y7,y6,y5,y4,y3,y2,y1,y0: in STD_LOGIC_VECTOR(N-1 downto 0);
	 s: in STD_LOGIC_VECTOR(2 downto 0);
	 f: out STD_LOGIC_VECTOR(N-1 downto 0) );
end genericMux8x1;

architecture behavior of genericMux8x1 is
begin
	f <=    y0 when s="000" else
            y1 when s="001" else
            y2 when s="010" else
            y3 when s="011" else
            y4 when s="100" else
            y5 when s="101" else
            y6 when s="110" else
            y7;

end behavior;
