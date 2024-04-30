-------------------------------------------------
-- Author:      Chris Coulston
-- Date:        Fall 2002
-- Purp:        A sweet register with asynchronous
--		active low reset and a normal
--		load/hold control input.
-------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.basicBuildingBlocks_package.all;

-- Generic is the width of the registers in the register file
entity generic8RegisterFile is
        generic(N: integer := 16);
        port (  clk, resetn: in STD_LOGIC;
                write: in STD_LOGIC;
                wrAddr: in  STD_LOGIC_VECTOR(2 downto 0);
                rdAddr: in  STD_LOGIC_VECTOR(2 downto 0);
                D: in STD_LOGIC_VECTOR(N-1 downto 0);
                Q: out STD_LOGIC_VECTOR(N-1 downto 0) );
end generic8RegisterFile;

architecture structure of generic8RegisterFile is

    signal regWrite: STD_LOGIC_VECTOR(7 downto 0);
    signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7: STD_LOGIC_VECTOR(15 downto 0);
    
begin
   
    writeSelect: decode3x8 PORT MAP (dataIn => write, sel => wrAddr, y => regWrite);
    
    r0: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(0), D => D, Q => Q0);
    r1: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(1), D => D, Q => Q1);        
    r2: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(2), D => D, Q => Q2);            
    r3: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(3), D => D, Q => Q3);
    r4: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(4), D => D, Q => Q4);
    r5: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(5), D => D, Q => Q5);
    r6: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(6), D => D, Q => Q6);
    r7: genericRegister
            GENERIC MAP (N)
            PORT MAP(clk => clk, resetn => resetn, load => regWrite(7), D => D, Q => Q7);

    outMux: genericMux8x1 
            GENERIC MAP(16)
            PORT MAP (y7 => Q7, y6 => Q6, y5 => Q5, y4 => Q4, y3 => Q3, y2 => Q2, y1 => Q1, y0 => Q0, s => rdAddr, f => Q);

end structure;

