----------------------------------------------------------------
-- file: signalAcquireDatapath
-- purp: datapath to sample analog audio
----------------------------------------------------------------

-------- libraries --------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.signalAcquire_package.all;
use work.basicbuildingblocks_package.all; -- basic building blocks

-------- entity --------
entity signalAcquire_Datapath is
    PORT(clk: in  STD_LOGIC;
         resetn: in  STD_LOGIC;
		 cw: in STD_LOGIC_VECTOR(CW_WIDTH - 1 downto 0);
		 sampleCntCtrl: in std_logic_vector(1 downto 0);
		 sw: out STD_LOGIC_VECTOR(DATAPATH_SW_WIDTH - 1 downto 0);
		 an7606data: in STD_LOGIC_VECTOR(15 downto 0);
		 rfAddr: in STD_LOGIC_VECTOR(2 downto 0);
		 rfData: out STD_LOGIC_VECTOR(15 downto 0);
		 trigger: out std_logic);
end signalAcquire_Datapath;

-------- architecture --------
 architecture behavior of signalAcquire_Datapath is
	-- internal:
	signal shortd0, shortd1: std_logic_vector(7 downto 0);
	signal longd0, longd1: std_logic_vector(23 downto 0);
	signal regd0, regd1: std_logic_vector(2 downto 0);
  	signal chSample: std_logic_vector(2 downto 0);
  	signal sampleCount: std_logic_vector(15 downto 0);
  	-- control word:
  	signal shortCntCtrl, longCntCtrl, regCntCtrl: std_logic_vector(1 downto 0);
  	signal recordConv: std_logic;
  	-- status word:
  	signal short, long, recorded8: std_logic;
begin
	---- signal mapping ----
	-- internal:
	shortd1 <= SHORT_DELAY_50Mhz_COUNTS;
	longd1 <= LONG_DELAY_50Mhz_COUNTS;
	regd1 <= "111";
	chSample <= regd0;
	-- control word:
	shortCntCtrl <= cw(SHORTCNT_CW_SINDEX) & cw(SHORTCNT_CW_SINDEX - 1);
	longCntCtrl <= cw(LONGCNT_CW_SINDEX) & cw(LONGCNT_CW_SINDEX - 1);
	regCntCtrl <= cw(REGCNT_CW_SINDEX) & cw(REGCNT_CW_SINDEX - 1);
	recordConv <= cw(REGWRITE_CW_INDEX);
	-- status word:
	sw <= short & long & recorded8;
	---- compontent mapping ----
	convertSampleRate: genericCompare
    	generic map(16)
    	port map(x => sampleCount, y => THRESHOLD_CONSTANT, g => open, l => open, e => trigger);
    sampleCounter: genericCounter
		generic map(16)
		port map(d => x"0000", q => sampleCount, c => sampleCntCtrl, clk => clk, resetn => resetn);
	shortCounter: genericCounter
		generic map(8)
		port map(d => x"00", q => shortd0, c => shortCntCtrl, clk => clk, resetn => resetn);
	shortComparitor: genericCompare
		generic map(8)
		port map(x => shortd0, y => shortd1, e => short, g => open, l => open);
	longCounter: genericCounter
		generic map(24)
		port map(d => x"000000", q => longd0, c => longCntCtrl, clk => clk, resetn => resetn);
	longComparitor: genericCompare
		generic map(24)
		port map(x => longd0, y => longd1, e => long, g => open, l => open);
	ramCounter: genericCounter
		generic map(3)
		port map(d => "000", q => regd0, c => regCntCtrl, clk => clk, resetn => resetn);
	ramComparitor: genericCompare
		generic map(3)
		port map(x => regd0, y => regd1, e => recorded8, g => open, l => open);
	chSamples: channelRam
		port map(d => an7606data, q => rfData, write => recordConv, readAddress => rfAddr, writeAddress => chSample, clk => clk, resetn => resetn);
end behavior;

----------------------------------------------------------------
-- authors: jack martin, raul gerhardus
-- refrence: chris coulston
-- date: 04/26/2024
----------------------------------------------------------------