-------------------------------------------------
-- Author:      Chris Coulston
-- Date:        Fall 2002
-- Purp:        A sweet register with asynchronous
--		active low reset and a normal
--		load/hold control input.
-------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity genericRegister is
        generic(N: integer := 4);
        port (  clk, resetn,load: in STD_LOGIC;
                d: in  STD_LOGIC_VECTOR(N-1 downto 0);
                q: out STD_LOGIC_VECTOR(N-1 downto 0) );
end genericRegister;

architecture behavior of genericRegister is
begin

	process(clk)  
	begin
		if (rising_edge(clk)) then
			if (resetn = '0') then 
	           q <= (others => '0');
            elsif (load = '1') then 
               q <= d; end if;             
            end if;        
    end process;
end architecture;

