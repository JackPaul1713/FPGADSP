--------------------------------------------------
-- Name: Chris Coulston
-- Date: Fall 2022
-- Purp: A package for the generic VHDL components
-- To use include the following line at the top
-- of your source VHDL file:
--	use work.basicBuildingBlock_package.all;
--
-- Then make sure that the buildingBlocksVhdl 
-- folder is added to your project.  In a real
-- development environment, these files would be 
-- tested, verified with known, predictiable 
-- behavior.  As a result you would share these
-- amoung many projects. As a consquence, do not
-- store this folder in a project directory, put
-- it on the same level as your project folder.
-- Do not duplicate this folder for each project.
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

package basicBuildingBlocks_package is

component flagRegister is
	generic (N: integer := 8);
	port(	clk: in  STD_LOGIC;
			resetn : in  STD_LOGIC;
			set, clear: in std_logic_vector(N-1 downto 0);
			Q: out std_logic_vector(N-1 downto 0));
end component;

	
	component genericAdder is
	    generic(N: integer := 4);
	    port(a,b: in std_logic_vector(N-1 downto 0);
		 sum: out std_logic_vector(N-1 downto 0));
	end component;

	component genericAdderSubtrctor is
	    generic(N: integer := 4);
	    port(a,b: in std_logic_vector(N-1 downto 0);
		 fnc: in std_logic;
		 sum: out std_logic_vector(N-1 downto 0));
	end component;

	component genericCompare is
	    generic(N: integer := 4);
	    port(x,y : in std_logic_vector(N-1 downto 0);
		 g,l,e: out std_logic);
	end component;

	component genericCounter is
	    generic(N: integer:=4);
	    port(clk,resetn : in std_logic;
		 c: in std_logic_vector(1 downto 0);
		 d : in  std_logic_vector(N-1 downto 0);
		 q : out std_logic_vector(N-1 downto 0));
	end component;


	component genericMux2x1 is
	    	generic(N: integer := 4);
    		port(y1,y0: in std_logic_vector(N-1 downto 0);
			 s: in std_logic;
			 f: out std_logic_vector(N-1 downto 0) );
	end component;

component genericMux4x1 is
    generic(N: integer := 8);
    port(y3,y2,y1,y0: in STD_LOGIC_VECTOR(N-1 downto 0);
	 s: in STD_LOGIC_VECTOR(1 downto 0);
	 f: out STD_LOGIC_VECTOR(N-1 downto 0) );
end component;

    component genericMux8x1 is
        generic(N: integer := 8);
        port(y7,y6,y5,y4,y3,y2,y1,y0: in STD_LOGIC_VECTOR(N-1 downto 0);
             s: in STD_LOGIC_VECTOR(2 downto 0);
             f: out STD_LOGIC_VECTOR(N-1 downto 0) );
    end component;

	component genericRegister is
        	generic(N: integer := 4);
        	port (  clk, resetn,load: in std_logic;
         	       d: in  std_logic_vector(N-1 downto 0);
          	      q: out std_logic_vector(N-1 downto 0) );
	end component;
	
	component decode3x8 is
            port(   dataIn :in STD_LOGIC;
                    sel :in STD_LOGIC_VECTOR(2 downto 0);
                    y : out STD_LOGIC_VECTOR(7 downto 0));
            end component;

           
    component generic8RegisterFile is
            generic(N: integer := 16);
            port (  clk, resetn: in STD_LOGIC;
                    write: in STD_LOGIC;
                    wrAddr: in  STD_LOGIC_VECTOR(2 downto 0);
                    rdAddr: in  STD_LOGIC_VECTOR(2 downto 0);
                    D: in STD_LOGIC_VECTOR(N-1 downto 0);
                    Q: out STD_LOGIC_VECTOR(N-1 downto 0) );
    end component;
            

end package;


