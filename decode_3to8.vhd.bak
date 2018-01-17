library ieee;
use ieee.std_logic_1164.all;

entity decode_3to8 is 
   port( w  : in  std_logic_vector(2 downto 0);
	 en : in  std_logic;
	 y  : out  std_logic_vector(7 downto 0)
  );
end entity decode_3to8;

--Draw a neat, clearly-labeled schematic of a 3-to-8 binary address decoder.  The 3-to-8 binary address decoder 
--comprises only 2-to-4 binary address decoders arranged in a tree structure.  No other logic is allowed. 

--Navigate to File → Open… in Modelsim ASE and open file decode_3to8.vhd.  Use the Modelsim ASE to model the 3-to-8 binary address decoder designed in step 1) of this 
--task using structural modeling.  Name the 3-to-8 binary address decoder entity decode_3to8 and specify the 3-to-8 binary address decoder according to the interface specification in Table 1. 

--In an architecture named structure, model the 3-to-8 binary address decoder using entity instantiation statements.  
--Consider using constant objects when appropriate. 


architecture structure of decode_3to8 is 

 signal enable : std_logic_vector(1 downto 0);
--enable : in std_logic;

begin

enable(1) <= not w(2) or en;
enable(0) <= w(2) or en;

decode1_3to8 : entity work.decode_2to4 (behavior) 
    PORT MAP(w(1 downto 0) => w(1 downto 0), en => enable(1), y(3 downto 0) => y(7 downto 4) ); 

decode2_3to8 : entity work.decode_2to4 (behavior) 
    PORT MAP(w(1 downto 0) => w(1 downto 0), en => enable(0),y(3 downto 0) => y(3 downto 0)  );

end architecture structure;



