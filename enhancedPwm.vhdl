----------------------------------------------------------------
-- file: enhancedpwm
-- purp: generate 10bit enhanced pwm
----------------------------------------------------------------

-------- libraries --------
library ieee;
use ieee.std_logic_1164.all;
use work.basicbuildingblocks_package.all;

-------- entity --------
entity enhancedpwm is
  port(dutyCycle: in std_logic_vector(16 downto 0);
       pwmSignal, rollOver: out std_logic;
       pwmCount: out std_logic_vector(9 downto 0);
       clk, resetn, enb: in std_logic);
end enhancedpwm;

-------- architecture --------
architecture behavior of enhancedpwm is
  signal stepsHigh: std_logic_vector(10 downto 0);
  signal stepCount17: std_logic_vector(10 downto 0);
  signal stepCount: std_logic_vector(9 downto 0);
  signal stepCounterControl, rawControl: std_logic_vector(1 downto 0);
  signal rollReload, stepGtr: std_logic;
begin
  ---- signal mapping ----
  pwmCount <= stepCount;
  rollOver <= rollReload;
  stepCount17 <= '0' & stepCount; -- pad step count
  rawControl <= enb & rollReload;
  stepCounterControl <= "00" when rawControl = "00" else -- hold
                        "11" when rawControl = "01" else -- reset
                        "10" when rawControl = "10" else -- increment
                        "01"; -- "11" -- load 0x0000

  ---- component mapping ----
  dutyCycleRegister: genericRegister -- holds duty cycle
    generic map(11)
    port map(d => dutyCycle(16 downto 6), q => stepsHigh, load => rollReload, clk => clk, resetn => resetn);
  stepCounter: genericCounter -- counts steps
    generic map(10)
    port map(d => "0000000000", q => stepCount, c => stepCounterControl, clk => clk, resetn => resetn);
  highCompare: genericCompare -- compares step count to steps high
    generic map(11)
    port map(x => stepsHigh, y => stepCount17, g => stepGtr, l => open, e => open);   
  rollCompare: genericCompare -- resets step count, loads new duty cycle
    generic map(10)
    port map(x => "1111111111", y => stepCount, g => open, l => open, e => rollReload);

  ---- processes ----
  process(clk)
  begin 
    if(rising_edge(clk)) then
      if(resetn = '0') then 
        pwmSignal <= '0';
      else 
        pwmSignal <= stepGtr; 
      end if;
    end if;       
  end process;
end behavior;

----------------------------------------------------------------
-- author: jack martin
-- date: 09/04/2023
----------------------------------------------------------------