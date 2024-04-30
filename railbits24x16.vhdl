----------------------------------------------------------------
-- file: rail
-- purp: rail a twos complement number from a higher number of 
--       bits to 16 bits
----------------------------------------------------------------

-------- libraries --------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.basicbuildingblocks_package.all;
use work.signalAcquire_Package.all;

-------- entity --------
entity railbits24x16 is
  port(---- inputs ----
  	   twos24: in std_logic_vector(23 downto 0); --we have 18 bits of output, so top 6 bits are just sign extension
  	   ---- outputs ----
  	   twos16: out std_logic_vector(15 downto 0));
end railbits24x16;

-------- architecture --------
architecture behavior of railbits24x16 is
  signal toohigh: std_logic;
  signal toolow: std_logic;
begin
  ---- signal mapping ----
  --considering that we want to multiply by 4, we need to check if the number in bits 17:0 isn't too big to be multiplied by 4
  toohigh <= '1' when twos24(23) = '0' and (twos24(16) = '1' or twos24(15) = '1') else '0';
  toolow <= '1' when twos24(23) = '1' and (twos24(16) = '0' or twos24(15) = '0') else '0';
  twos16 <= x"7FFF" when toohigh = '1' else
            x"8000" when toolow = '1' else
            twos24(23) & twos24(14 downto 0);
end behavior;

----------------------------------------------------------------
-- authors: jack martin, walter bhaylo, raul gerhardus
-- date: 04/26/2024
----------------------------------------------------------------