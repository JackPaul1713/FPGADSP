--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Fall 2022
-- File:	signalAcquire_tb.vhd
--
-- Purp: A nice testbench for the signalAcquire module
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

ENTITY signalAcquire_tb IS
END signalAcquire_tb;
 
ARCHITECTURE behavior OF signalAcquire_tb is

   --Inputs
   signal clk_t : STD_LOGIC;
   signal resetn_t : STD_LOGIC;   
   signal an7606data_t : STD_LOGIC_VECTOR (15 downto 0);
   signal an7606convst_t : STD_LOGIC;   
   signal an7606cs_t : STD_LOGIC;   
   signal an7606rd_t : STD_LOGIC; 
   signal an7606reset_t : STD_LOGIC;   
   signal an7606od_t : STD_LOGIC_VECTOR (2 downto 0);
   signal an7606busy_t : STD_LOGIC; 
   signal sample_t: std_logic_vector(15 downto 0);
   signal sampready_t: STD_LOGIC; 
   
    component signalAcquire is
    port(clk: in std_logic;
         resetn: in std_logic;
         an7606data: in std_logic_vector(15 downto 0);
         an7606convst, an7606cs, an7606rd, an7606reset: out std_logic;
         an7606od: out std_logic_vector(2 downto 0);
         an7606busy: in std_logic;
         sample: out std_logic_vector(15 downto 0);
         sampready: out std_logic);	   
    end component;  
	
BEGIN

    an7606: an7606_tb
        PORT MAP (  clk => clk_t,
		            an7606data => an7606data_t,
		            an7606convst => an7606convst_t,
		            an7606cs => an7606cs_t,
		            an7606rd => an7606rd_t,
		            an7606reset => an7606reset_t,
		            an7606od => an7606od_t,
		            an7606busy => an7606busy_t);	
 
    uut: signalAcquire 
        PORT MAP (  clk => clk_t,
                    resetn => resetn_t,
		            an7606data => an7606data_t,
		            an7606convst => an7606convst_t,
		            an7606cs => an7606cs_t,
		            an7606rd => an7606rd_t,
		            an7606reset => an7606reset_t,
		            an7606od => an7606od_t,
		            an7606busy => an7606busy_t,
                    sample => sample_t,
                    sampready => sampready_t);	

    resetn_t <= '0', '1' after clk_period;		

   -- Clock process definitions
   clk_process :process
   begin
		clk_t <= '0';
		wait for clk_period/2;
		clk_t <= '1';
		wait for clk_period/2;
   end process;
END behavior;
