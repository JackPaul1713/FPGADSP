----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enhancedPwm_tb is
--  Port ( );
end enhancedPwm_tb;

architecture Behavioral of enhancedPwm_tb is

   --Inputs
   signal clk_t, resetn_t, pwmSignal_t, enb_t, rollOver_t: STD_LOGIC;
   signal dutyCycle_t: STD_LOGIC_VECTOR(16 downto 0);
   signal pwmCount_t: STD_LOGIC_VECTOR(13 downto 0);
   constant clk_period : time := 2 ns;			-- 50Mhz crystal input (XTL_IN).

component enhancedPwm is
    PORT ( clk : in  STD_LOGIC;
           resetn : in  STD_LOGIC;
           enb: in STD_LOGIC;
           dutyCycle: in STD_LOGIC_VECTOR(16 downto 0);
           pwmCount: out STD_LOGIC_VECTOR(13 downto 0);
           rollOver: out STD_LOGIC;
           pwmSignal: out STD_LOGIC);		   
end component;
	
BEGIN
    uut: enhancedPwm 
        PORT MAP (  clk => clk_t,
                    resetn => resetn_t,
                    enb => enb_t,
                    dutyCycle => dutyCycle_t,
                    pwmCount => pwmCount_t,
                    rollOver => rollOver_t,
                    pwmSignal => pwmSignal_t);	

    resetn_t <= '0', '1' after clk_period;		
    dutyCycle_t <= "00100000000000000", "01000000000000000" after 131072*clk_period, "10000000000000000" after 2*131072*clk_period, "00000000000000000" after 3*131072*clk_period;
    enb_t <= '1', '0' after 786432*clk_period;
    
   -- Clock process definitions
   clk_process :process
   begin
		clk_t <= '0';
		wait for clk_period/2;
		clk_t <= '1';
		wait for clk_period/2;
   end process;   
END Behavioral;

