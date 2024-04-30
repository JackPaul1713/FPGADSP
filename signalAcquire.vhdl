----------------------------------------------------------------
-- file: signalAcquire
-- purp: sample analog audio
----------------------------------------------------------------

-------- libraries --------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Include any packages that are instantiated
use work.basicbuildingblocks_package.all; -- basic building blocks
use work.signalAcquire_package.all;

-------- entity --------
entity signalAcquire is
    PORT(clk: in  STD_LOGIC;
         resetn: in STD_LOGIC;
		 an7606data: in STD_LOGIC_VECTOR(15 downto 0);
		 an7606convst, an7606cs, an7606rd, an7606reset: out STD_LOGIC;
		 an7606od: out STD_LOGIC_VECTOR(2 downto 0);
		 an7606busy : in STD_LOGIC;
		 sample: out STD_LOGIC_VECTOR(15 downto 0);
		 sampready: out std_logic);		   
end signalAcquire;

-------- architecture --------
architecture behavior of signalAcquire is
	signal cw: std_logic_vector(10 downto 0);
	signal sw: std_logic_vector(4 downto 0);
	signal dsw: std_logic_vector(2 downto 0);
	signal trigger: std_logic;
	signal sampleCntCtrl: std_logic_vector(1 downto 0);
begin
	---- signal mapping ----
	sampready <= trigger;
    an7606convst <= cw(CONV_CW_INDEX);
	an7606rd <= cw(READ_CW_INDEX);
	an7606cs <= cw(CS_CW_INDEX);
	an7606reset <= cw(RESETADC_CW_INDEX);
	an7606od <= "000";
	sw <= dsw(0) & an7606busy & trigger & dsw(1) & dsw(2);
    ---- component mapping ----
    ctrlpath: signalAcquire_Ctrlpath
    	port map(cw => cw, sw => sw, sampleCntCtrl => sampleCntCtrl, clk => clk, resetn => resetn);
    datapath: signalAcquire_Datapath
    	port map(cw => cw, sw => dsw, an7606data => an7606data, rfAddr => "000", rfData => sample, trigger => trigger, sampleCntCtrl => sampleCntCtrl, clk => clk, resetn => resetn);
end behavior;

----------------------------------------------------------------
-- authors: jack martin, raul gerhardus
-- refrence: chris coulston
-- date: 04/26/2024
----------------------------------------------------------------