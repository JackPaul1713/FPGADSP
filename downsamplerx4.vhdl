----------------------------------------------------------------
-- file: downsamplerx4
-- purp: pass 1 N bit sample for every 4 samples
----------------------------------------------------------------

-------- libraries --------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.basicbuildingblocks_package.all;
use work.signalAcquire_Package.all;

-------- entity --------
entity downsamplerx4 is
  generic(N: integer := 16);
  port(---- inputs ----
  	   clk: in std_logic;
       resetn: in std_logic;
       sampready: in std_logic;
       sample: in std_logic_vector(N-1 downto 0);
       ---- outputs ----
       sampreadyd4: out std_logic;
       sampled4: out std_logic_vector(N-1 downto 0));
end downsamplerx4;

-------- architecture --------
architecture behavior of downsamplerx4 is
  signal latch: std_logic;
  signal count: std_logic_vector(1 downto 0);
  signal sampCntCtrl: std_logic_vector(1 downto 0);
begin
  ---- signal mapping ----
  sampCntCtrl <= sampready & '0';
  ---- componet mapping ----
  sampleCounter: genericCounter
    generic map(2)
    port map(d => "00", q => count, c => sampCntCtrl, clk => clk, resetn => resetn);
  ---- processes ----
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(resetn = '0') then
        sampreadyd4 <= '0';
        latch <= '0';
      else
        if(latch = '0') then
          if(count = "11") then -- when count equals 4
            sampreadyd4 <= '1'; -- set sampreadyd4 high 
            sampled4 <= sample; -- set sampled4 to sample
            latch <= '1';
          end if;
        elsif(latch = '1') then
          sampreadyd4 <= '0'; -- set sampreadyd4 low
          if(count = "00") then -- when count equals 0
            latch <= '0';
          end if;
        end if;
      end if;
    end if;       
  end process;
end behavior;

----------------------------------------------------------------
-- authors: jack martin
-- date: 04/27/2024
----------------------------------------------------------------