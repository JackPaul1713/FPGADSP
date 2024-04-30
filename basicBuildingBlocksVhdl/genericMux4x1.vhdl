--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2002
-- Purp: A generic 4:1 mux
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity genericMux4x1 is
    generic(N: integer := 8);
    port(y3,y2,y1,y0: in STD_LOGIC_VECTOR(N-1 downto 0);
	 s: in STD_LOGIC_VECTOR(1 downto 0);
	 f: out STD_LOGIC_VECTOR(N-1 downto 0) );
end genericMux4x1;

architecture behavior of genericMux4x1 is
begin
	f <= y0 when s="00" else
             y1 when s="01" else
             y2 when s="10" else
             y3 ;

end behavior;
