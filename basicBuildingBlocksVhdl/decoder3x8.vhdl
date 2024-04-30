--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2002
-- Purp: A generic 2:1 mux
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity decode3x8 is
    port(   dataIn :in STD_LOGIC;
            sel :in STD_LOGIC_VECTOR(2 downto 0);
            y : out STD_LOGIC_VECTOR(7 downto 0));
end entity;

architecture behavior of decode3x8 is

begin
	y <=	"00000001" when (sel="000" and dataIn = '1') else
            "00000010" when (sel="001" and dataIn = '1')  else
            "00000100" when (sel="010" and dataIn = '1')  else
            "00001000" when (sel="011" and dataIn = '1')  else
            "00010000" when (sel="100" and dataIn = '1')  else
            "00100000" when (sel="101" and dataIn = '1')  else
            "01000000" when (sel="110" and dataIn = '1')  else
            "10000000" when (sel="111" and dataIn = '1')  else
            "00000000";

end behavior;
