--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Fall 2023
-- File:	signalAcquire_Package.vhd
--
-- Purp: Defines signalAcquire specific components and defines constants
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

-------- libraries --------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package signalAcquire_Package is
	-------- constants --------
	-- clock:
	CONSTANT CLK_PERIOD: time := 20 ns; -- 50Mhz crystal input (XTL_IN)
	-- control word:
	CONSTANT CONV_CW_INDEX: NATURAL := 10;
	CONSTANT READ_CW_INDEX: NATURAL := 9;
	CONSTANT CS_CW_INDEX: NATURAL := 8;
	CONSTANT RESETADC_CW_INDEX: NATURAL := 7;
	CONSTANT LONGCNT_CW_SINDEX: NATURAL := 6;
	CONSTANT SHORTCNT_CW_SINDEX: NATURAL := 4;
	CONSTANT REGCNT_CW_SINDEX: NATURAL := 2;
	CONSTANT REGWRITE_CW_INDEX: NATURAL := 0;
	-- status word:
	CONSTANT SHORTDONE_SW_INDEX: NATURAL := 0;
	CONSTANT LONGDONE_SW_INDEX: NATURAL := 1;
	CONSTANT TRIGGER_SW_INDEX: NATURAL := 2;
	CONSTANT BUSY_SW_INDEX: NATURAL := 3;
	CONSTANT RECORDED8_SW_INDEX: NATURAL := 4;
	-- fsm:
	CONSTANT DATAPATH_SW_WIDTH: NATURAL := 3; -- busy and trigger are external status words
	CONSTANT SW_WIDTH: NATURAL := 5;
	CONSTANT CW_WIDTH: NATURAL := 11;
	-- delays:
	CONSTANT LONG_DELAY_50Mhz_CONST_WIDTH: NATURAL := 24;
	CONSTANT LONG_DELAY_50Mhz_COUNTS: STD_LOGIC_VECTOR(LONG_DELAY_50Mhz_CONST_WIDTH - 1 downto 0) := x"0000FF"; -- FIXME, change back to 00FFFF
	CONSTANT SHORT_DELAY_50Mhz_CONST_WIDTH: NATURAL := 8; 
	CONSTANT SHORT_DELAY_50Mhz_COUNTS: STD_LOGIC_VECTOR(SHORT_DELAY_50Mhz_CONST_WIDTH - 1 downto 0) := x"10"; --right now this is 320 ns
	-- threshold conversions:
	-- You need to determine the 16-bit 2s complement ADC values for these voltages
	CONSTANT THRESHOLD_CONSTANT: STD_LOGIC_VECTOR(15 downto 0) := x"09B4"; -- For 80 kHz - 16 samples for assert conversion stage

	-------- types --------
	type state_type is (RESET, STABILIZE, RESETADC, WAITTRIGGER, ASSERTCONV, WHILEBUSY0, WHILEBUSY1, PAUSE, LATCH, RECORDSAMP, CLRSHORTDELAY);

	-------- components --------
	component channelRam is
		port(clk, resetn, write: in std_logic;
    		 readAddress, writeAddress: in std_logic_vector(2 downto 0);
    		 d: in std_logic_vector(15 downto 0);
    		 q: out std_logic_vector(15 downto 0));
	end component;

	component signalAcquire_Ctrlpath
		port(clk : in  STD_LOGIC;
         	 resetn : in  STD_LOGIC;
         	 sw: in STD_LOGIC_VECTOR(SW_WIDTH - 1 downto 0);
        	 cw: out STD_LOGIC_VECTOR (CW_WIDTH - 1 downto 0);
        	 sampleCntCtrl: out STD_LOGIC_VECTOR(1 downto 0));
	end component;
	component signalAcquire_Datapath
		port(clk: in  STD_LOGIC;
        	 resetn: in  STD_LOGIC;
			 cw: in STD_LOGIC_VECTOR(CW_WIDTH - 1 downto 0);
			 sampleCntCtrl: in std_logic_vector(1 downto 0);
			 sw: out STD_LOGIC_VECTOR(DATAPATH_SW_WIDTH - 1 downto 0);
			 an7606data: in STD_LOGIC_VECTOR(15 downto 0);
			 rfAddr: in STD_LOGIC_VECTOR(2 downto 0);
			 rfData: out STD_LOGIC_VECTOR(15 downto 0);
			 trigger: out std_logic);
	end component;
	
	component an7606_tb IS
	    PORT(clk: in  STD_LOGIC;
	         an7606data: out STD_LOGIC_VECTOR(15 downto 0);
	         an7606convst, an7606cs, an7606rd, an7606reset: in STD_LOGIC;
	         an7606od: in STD_LOGIC_VECTOR(2 downto 0);
	         an7606busy : out STD_LOGIC);
	end component;
end package;