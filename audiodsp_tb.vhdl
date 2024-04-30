----------------------------------------------------------------
-- file: audiodsp
-- purp: sample analog audio, pass through, send samples as 
--     duty cycle
----------------------------------------------------------------

-------- libraries --------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.basicbuildingblocks_package.all;
use work.signalAcquire_Package.all;

-------- entity --------
entity audiodsp_tb is
end audiodsp_tb;

-------- architecture --------
architecture behavior of audiodsp_tb is
  ---- audio dsp test signals ----
  signal clk_t: std_logic;
  signal resetn_t: std_logic;
  signal pwmSignal_t: std_logic;
  ---- an7606 test signals ----
  signal an7606data_t: std_logic_vector(15 downto 0);
  signal an7606convst_t: std_logic;   
  signal an7606cs_t: std_logic;   
  signal an7606rd_t: std_logic; 
  signal an7606reset_t: std_logic;   
  signal an7606od_t: std_logic_vector(2 downto 0);
  signal an7606busy_t: std_logic;
  ---- test components ----
  component audiodsp is
    port(clk: in std_logic;
         resetn: in std_logic;
         an7606data: in std_logic_vector(15 downto 0);
         an7606busy: in std_logic;
         buttons: in std_logic_vector(3 downto 0);
         an7606convst, an7606cs, an7606rd, an7606reset: out std_logic;
         an7606od: out std_logic_vector(2 downto 0);
         pwmSignal: out std_logic;
         leds: out std_logic_vector(3 downto 0));
  end component;
begin
  ---- component mapping ----
  simAn7606: an7606_tb
    port map(clk => clk_t,
             an7606data => an7606data_t,
             an7606convst => an7606convst_t,
             an7606cs => an7606cs_t,
             an7606rd => an7606rd_t,
             an7606reset => an7606reset_t,
             an7606od => an7606od_t,
             an7606busy => an7606busy_t);  
  uut: audiodsp
    port map(clk => clk_t, resetn => resetn_t,
             an7606data => an7606data_t, an7606busy => an7606busy_t, an7606convst => an7606convst_t, an7606cs => an7606cs_t, an7606rd => an7606rd_t, an7606reset => an7606reset_t, an7606od => an7606od_t,
             buttons => "0000", leds => open,
             pwmSignal => pwmSignal_t);
  
  ---- simultate signals ----
  resetn_t <= '0', '1' after clk_period;
  -- clock process:
  clk_process: process
  begin
    clk_t <= '0';
    wait for clk_period/2;
    clk_t <= '1';
    wait for clk_period/2;
  end process;
end behavior;

----------------------------------------------------------------
-- authors: jack martin, raul gerhardus
-- date: 09/04/2023
----------------------------------------------------------------