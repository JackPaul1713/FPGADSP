--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2002
-- Purp: A generic adder
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity genericAdder is
    generic(N: integer := 4);
    port(a,b: in STD_LOGIC_VECTOR(N-1 downto 0);
	 sum: out STD_LOGIC_VECTOR(N-1 downto 0));
end genericAdder;

architecture behavior of genericAdder is

begin
	sum <= a + b;

end behavior;