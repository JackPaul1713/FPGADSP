--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2002
-- Purp: A magnitude comparator (unsigned)
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity genericCompare is
    generic(N: integer := 4);
    port(   x,y : in STD_LOGIC_VECTOR(N-1 downto 0);
	       g,l,e: out STD_LOGIC);
end genericCompare;

architecture behavior of genericCompare is
	signal tmp : STD_LOGIC_VECTOR(2 downto 0);
begin
	tmp <= "100" when x > y else
	       "010" when x < y else
		   "001";
	g <= tmp(2);
	l <= tmp(1);
	e <= tmp(0);
end behavior;
