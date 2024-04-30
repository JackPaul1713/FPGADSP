library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity genericAdderSubtractor is
    generic(N: integer := 4);
    port(a,b: in STD_LOGIC_VECTOR(N-1 downto 0);
	 fnc: in STD_LOGIC;
	 sum: out STD_LOGIC_VECTOR(N-1 downto 0));
end genericAdderSubtractor;

architecture behavior of genericAdderSubtractor is

begin
	sum <=  a + b when fnc = 0 else
		a - b;

end behavior;