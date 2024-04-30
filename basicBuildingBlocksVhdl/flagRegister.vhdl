--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Jan 10, 2015
-- File:	flagRegister.vhdl
-- Event:	Lab2
--	Crs:	ECE 383
--
-- Purp:	A flag register that will (hopefully) interface to the 
--			microBlaze in Lab 3.  
--
-- Documentation:	I pulled some information from chapter .
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
library IEEE;		
use IEEE.std_logic_1164.all; 

entity flagRegister is
	Generic (N: integer := 8);
	Port(	clk: in  STD_LOGIC;
			resetn : in  STD_LOGIC;
			set, clear: in std_logic_vector(N-1 downto 0);
			Q: out std_logic_vector(N-1 downto 0));
end flagRegister;

architecture behavior of flagRegister is
	
	signal processQ: std_logic_vector(N-1 downto 0); 
	
begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			if (resetn = '0') then
				processQ <= (others => '0');
			else 
				processQ <= (processQ or set) and (not clear);
			end if;
		end if;
	end process;
 
	Q <= processQ;
	
end behavior;