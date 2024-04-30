----------------------------------------------------------------
-- file: rail
-- purp: test railing
----------------------------------------------------------------

-------- libraries --------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.basicbuildingblocks_package.all;
use work.signalAcquire_Package.all;

-------- entity --------
entity railbits24x16_tb is
end railbits24x16_tb;

-------- architecture --------
architecture behavior of railbits24x16_tb is
  signal clk_t: std_logic;
  signal twos24_tb: std_logic_vector(23 downto 0);
  signal twos16_tb: std_logic_vector(15 downto 0);
  component railbits24x16 is
    port(twos24: in std_logic_vector(23 downto 0);
         twos16: out std_logic_vector(15 downto 0));
  end component;
begin
  ---- component mapping ----
  uut: railbits24x16
    port map(twos24 => twos24_tb, twos16 => twos16_tb);
  ---- simultate signals ----
  twos24_tb <= x"000000", x"800000" after clk_period * 8, x"7FFFFF" after clk_period * 16, x"FFFF00" after clk_period * 24, x"0000FF" after clk_period * 32, x"FF8000" after clk_period * 40, x"007FFF" after clk_period * 48;
  -- clock process:
  clk_process: process
  begin
    clk_t <= '0';
    wait for clk_period / 2;
    clk_t <= '1';
    wait for clk_period / 2;
  end process;
end behavior;

----------------------------------------------------------------
-- authors: jack martin, walter bhaylo, raul gerhardus
-- date: 04/26/2024
----------------------------------------------------------------