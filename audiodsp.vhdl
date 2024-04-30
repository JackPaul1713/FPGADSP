----------------------------------------------------------------
-- file: audiodsp
-- purp: sample analog audio, pass through, send samples as 
--       duty cycle
----------------------------------------------------------------

-------- libraries --------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use work.basicbuildingblocks_package.all;
use work.signalAcquire_Package.all;

-------- entity --------
entity audiodsp is
  port(---- input signals ----
       clk: in std_logic;
       resetn: in std_logic;
       an7606data: in std_logic_vector(15 downto 0);
       an7606busy: in std_logic;
       buttons: in std_logic_vector(3 downto 0);
       ---- output signals ----
       an7606convst, an7606cs, an7606rd, an7606reset: out std_logic;
       an7606od: out std_logic_vector(2 downto 0);
       sampled: out std_logic; -- has sampled, to check sample rate
       pwmSignal: out std_logic;
       leds: out std_logic_vector(3 downto 0));
end audiodsp;

-------- architecture --------
architecture behavior of audiodsp is
  ---- internal signals ----
  signal sampready: std_logic; -- sample ready
  signal sample: std_logic_vector(15 downto 0); -- sample
  signal D4sampready: std_logic; -- sample ready downsampled by 4
  signal D4sample: std_logic_vector(15 downto 0); -- sample downsampled by 4
  signal AAFsampready: std_logic; -- AAF done calculating output
  signal AAFsample24: std_logic_vector(23 downto 0);
  signal AAFsample: std_logic_vector(15 downto 0);
  
  signal LPFsampready: std_logic;
  signal LPFsample24: std_logic_vector(23 downto 0);
  signal LPFsample: std_logic_vector(15 downto 0);
  signal BPFsampready: std_logic;
  signal BPFsample24: std_logic_vector(23 downto 0);
  signal BPFsample: std_logic_vector(15 downto 0);
  signal HPFsampready: std_logic;
  signal HPFsample24: std_logic_vector(23 downto 0);
  signal HPFsample: std_logic_vector(15 downto 0);
  
  signal MUXsampready: std_logic;
  signal MUXsample: std_logic_vector(15 downto 0);
  signal MUXselect: std_logic_vector(1 downto 0);
  signal UMUXsample: std_logic_vector(15 downto 0);
  signal EXTsample: std_logic_vector(16 downto 0); -- extended sample

  -------- components --------
  component enhancedPwm is
    port(clk: in std_logic;
         resetn: in std_logic;
         enb: in std_logic;
         dutyCycle: in std_logic_vector(16 downto 0);
         pwmCount: out std_logic_vector(9 downto 0);
         rollOver: out std_logic;
         pwmSignal: out std_logic);
  end component;
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
  component downsamplerx4 is
    generic(N: integer := 16);
    port(clk: in std_logic;
         resetn: in std_logic;
         sampready: in std_logic;
         sample: in std_logic_vector(N-1 downto 0);
         sampreadyd4: out std_logic;
         sampled4: out std_logic_vector(N-1 downto 0));
  end component;
  component railbits24x16 is
      port(twos24: in std_logic_vector(23 downto 0);
           twos16: out std_logic_vector(15 downto 0));
  end component;
  component AAF is
    port(aclk : IN STD_LOGIC;
         s_axis_data_tvalid : IN STD_LOGIC;
         s_axis_data_tready : OUT STD_LOGIC;
         s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         m_axis_data_tvalid : OUT STD_LOGIC;
         m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0));
  end component;
  component LPF is
    port(aclk : IN STD_LOGIC;
         s_axis_data_tvalid : IN STD_LOGIC;
         s_axis_data_tready : OUT STD_LOGIC;
         s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         m_axis_data_tvalid : OUT STD_LOGIC;
         m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0));
  end component;
  component BPF is
    port(aclk : IN STD_LOGIC;
         s_axis_data_tvalid : IN STD_LOGIC;
         s_axis_data_tready : OUT STD_LOGIC;
         s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         m_axis_data_tvalid : OUT STD_LOGIC;
         m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0));
  end component;
  component HPF is
    port(aclk : IN STD_LOGIC;
         s_axis_data_tvalid : IN STD_LOGIC;
         s_axis_data_tready : OUT STD_LOGIC;
         s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         m_axis_data_tvalid : OUT STD_LOGIC;
         m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0));
  end component;
begin
  ---- signal mapping ----
  sampled <= sampready;
  UMUXsample <= MUXsample xnor x"7FFF"; -- shift up to unsigned
  EXTsample <= '0' & UMUXsample;
  ---- component mapping ----
  -- in/out:
  adcInterface: signalAcquire
    port map(clk => clk, resetn => resetn, 
             an7606data => an7606data, an7606convst => an7606convst, an7606cs => an7606cs, an7606rd => an7606rd, an7606reset => an7606reset,  an7606od => an7606od, an7606busy => an7606busy, 
             sample => sample, sampready => sampready);
  sampleMux: genericMux4x1
    generic map(16)
    port map(y3 => sample, y2 => LPFsample, y1 => BPFsample, y0 => HPFsample, 
             s => MUXselect, 
             f => MUXsample);
  ePwm: enhancedPwm
    port map(clk => clk, resetn => resetn, enb => '1', 
             pwmCount => open, rollOver => open,
             dutyCycle => extsample, pwmSignal => pwmSignal);
  -- dsp:
  AAFilter: AAF
    port map(aclk =>clk,
             s_axis_data_tvalid => sampready,
             s_axis_data_tready => open,
             s_axis_data_tdata  => sample,
             m_axis_data_tvalid => AAFsampready,
             m_axis_data_tdata => AAFsample24);         
  AFFRail: railbits24x16
    port map(twos24 => AAFsample24,
             twos16 => AAFsample);       
  D4Sampler: downsamplerx4
    generic map(16)
    port map(clk => clk,
             resetn => resetn,
             sampready => AAFsampready,
             sample => AAFsample,
             sampreadyd4 => D4sampready,
             sampled4 => D4sample);
  LPFiler: LPF
    port map(aclk =>clk,
             s_axis_data_tvalid => sampReady,
             s_axis_data_tready => open,
             s_axis_data_tdata  => sample,
             m_axis_data_tvalid => LPFsampready,
             m_axis_data_tdata => LPFsample24);  
  LPFRail: railbits24x16
    port map(twos24 => LPFsample24,
             twos16 => LPFsample);
  BPFiler: BPF
    port map(aclk =>clk,
             s_axis_data_tvalid => sampReady,
             s_axis_data_tready => open,
             s_axis_data_tdata  => sample,
             m_axis_data_tvalid => BPFsampready,
             m_axis_data_tdata => BPFsample24);  
  BPFRail: railbits24x16
    port map(twos24 => BPFsample24,
             twos16 => BPFsample);
  HPFiler: HPF
    port map(aclk =>clk,
             s_axis_data_tvalid => sampReady,
             s_axis_data_tready => open,
             s_axis_data_tdata  => sample,
             m_axis_data_tvalid => HPFsampready,
             m_axis_data_tdata => HPFsample24);  
  HPFRail: railbits24x16
    port map(twos24 => HPFsample24,
             twos16 => HPFsample);
  
  ---- processes ----
  process(clk)
  begin 
    if(rising_edge(clk)) then
      if(resetn = '0') then
        MUXselect <= "00"; -- select raw
        leds <= "0111";
      else
        if(buttons(3) = '0') then 
          MUXselect <= "00"; -- select raw
          leds <= "0111";
        elsif(buttons(2) = '0') then 
          MUXselect <= "01"; -- select lpf
          leds <= "1011";
        elsif(buttons(1) = '0') then 
          MUXselect <= "10"; -- selet bpf
          leds <= "1101";
        elsif(buttons(0) = '0') then 
          MUXselect <= "11"; -- select hpf
          leds <= "1110";
        end if;
      end if;
    end if;       
  end process;
end behavior;

----------------------------------------------------------------
-- authors: jack martin, walter bhaylo, raul gerhardus
-- date: 04/26/2024
----------------------------------------------------------------