--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Fall 2022
-- File:	an7606.vhd
--
-- Purp: A behavioral model of the AD7606 module on the AN706 module
--
-- Documentation:	No help
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;		
use work.signalAcquire_Package.all;					-- include your library here with added components ac97, ac97cmd

ENTITY an7606_tb IS
    PORT ( clk : in  STD_LOGIC;
		   an7606data: out STD_LOGIC_VECTOR(15 downto 0);
		   an7606convst, an7606cs, an7606rd, an7606reset: in STD_LOGIC;
		   an7606od: in STD_LOGIC_VECTOR(2 downto 0);
		   an7606busy : out STD_LOGIC);
END an7606_tb;
 
ARCHITECTURE behavior OF an7606_tb is
   
BEGIN
   
	-- Busy signal from AN7606 
   busy_process: process
   begin
		an7606busy <= '0';
		wait until (an7606convst = '0');
		wait until (an7606convst = '1');
		wait for 40ns;
		an7606busy <= '1';
		wait for 4us;
		an7606busy <= '0';
		--wait;
   end process;   

	-- Busy signal from AN7606 
   AN7606_DATA_process :process
   begin
		an7606data <= x"0000";		
		--wait until (an7606cs = '0');
		
		wait until (an7606rd = '0');
		an7606data <= x"1000";
		wait until (an7606rd = '1');
		
		wait until (an7606rd = '0');
		an7606data <= x"2222";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"3333";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"4444";
		wait until (an7606rd = '1');		
		wait until (an7606rd = '0');
		an7606data <= x"5555";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"6666";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"7777";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"8888";
		wait until (an7606rd = '1');
        
      -- Hold last data for at least one clock edge past read edge
      wait for 5*clk_period; 

      an7606data <= x"0000";		
		--wait until (an7606cs = '0');
		
		wait until (an7606rd = '0');
		an7606data <= x"4000";
		wait until (an7606rd = '1');
		
		wait until (an7606rd = '0');
		an7606data <= x"2222";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"3333";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"4444";
		wait until (an7606rd = '1');		
		wait until (an7606rd = '0');
		an7606data <= x"5555";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"6666";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"7777";
		wait until (an7606rd = '1');
		wait until (an7606rd = '0');
		an7606data <= x"8888";
		wait until (an7606rd = '1');
        
      -- Hold last data for at least one clock edge past read edge
      wait for 5*clk_period; 
   end process;      
	
	  

END behavior;
