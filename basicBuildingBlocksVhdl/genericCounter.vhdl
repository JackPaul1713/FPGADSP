------------------------------------------
-- Author:      Chris Coulston
-- Date:        Fall 2002
-- Purp:        A counter
--  c   Function
--  00  Hold
--  01  load
--  10  inc
--  11  reset
------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity genericCounter is
    generic(N: integer:=4);
    port(   clk,resetn : in std_logic;
            c: in STD_LOGIC_VECTOR(1 downto 0);
            d : in  STD_LOGIC_VECTOR(N-1 downto 0);
            q : out STD_LOGIC_VECTOR(N-1 downto 0));
end genericCounter;

architecture behavior of genericCounter is
    signal tmp: STD_LOGIC_VECTOR(N-1 downto 0);
begin

	process(clk)  
	begin
		if (rising_edge(clk)) then
			if (resetn = '0') then 
                tmp <= (others => '0');        
            else 
                case c is
                    when "00" => tmp <= tmp;
                    when "01" => tmp <= d;
                    when "10" => tmp <= tmp+1;
                    when others => tmp <= (others => '0');
                end case;
            end if;
        end if;        
    end process;
    q <= tmp;
end behavior;

