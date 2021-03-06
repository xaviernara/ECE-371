library ieee;
use ieee.std_logic_1164.all;

entity decode_3to8 is 
   port( w  : in  std_logic_vector(2 downto 0); --Binary address
	 en : in  std_logic; --Active high output enable
	 y  : out  std_logic_vector(7 downto 0) --One-hot address
  );
end entity decode_3to8;

--Draw a neat, clearly-labeled schematic of a 3-to-8 binary address decoder.  The 3-to-8 binary address decoder 
--comprises only 2-to-4 binary address decoders arranged in a tree structure.  No other logic is allowed. 

--Navigate to File → Open… in Modelsim ASE and open file decode_3to8.vhd.  Use the Modelsim ASE to model the 3-to-8 binary address decoder designed in step 1) of this 
--task using structural modeling.  Name the 3-to-8 binary address decoder entity decode_3to8 and specify the 3-to-8 binary address decoder according to the interface specification in Table 1. 

--In an architecture named structure, model the 3-to-8 binary address decoder using entity instantiation statements.  
--Consider using constant objects when appropriate. 


architecture structure of decode_3to8 is 

 --signal enable : std_logic_vector(1 downto 0);
 --enable : in std_logic;
--signal x : std_logic_vector(1 downto 0);
signal x : std_logic_vector(3 downto 0);
--constant unused1 : std_logic:='0';
--constant unused2 : std_logic:='0';


begin
	--y(7 downto 6) <= x;
	--x<=y(7 downto 6);
	--unused<= "0000";
	
	decode1_2to4 : entity work.decode_2to4(behavior)
		--PORT MAP(w(1) => '0', w(0) => w(2) , en => en, y(3 downto 2) => x, y(1 downto 0)=> open );
		--PORT MAP(w(1) => '0', w(0) => w(2) , en => en, y(3 downto 2) => x, y(1)=>unused1, y(0)=>unused2);
		--PORT MAP(w=> w(2), en => en, y(3) => x(1), y(0)=> x(0));
		--PORT MAP(w=> '0'& w(2) , en => en, y=>x);
		PORT MAP(w(1)=> '0', w(0)=> w(2) , en => en, y=>x);

	decode2_2to4 : entity work.decode_2to4(behavior)
		PORT MAP(w(1 downto 0) => w(1 downto 0), en => x(1), y(3 downto 0) => y(7 downto 4 ) );
	
	decode3_2to4 : entity work.decode_2to4(behavior)
		PORT MAP(w(1 downto 0) => w(1 downto 0), en => x(0), y(3 downto 0) => y(3 downto 0 ) );
	
--enable(1) <= not w(2) or en;
--enable(0) <= w(2) or en;
--
--decode1_2to4 : entity work.decode_2to4 (behavior) 
--    PORT MAP(w(1 downto 0) => w(1 downto 0), en => enable(1), y(3 downto 0) => y(7 downto 4) ); 
--
--decode2_2to4 : entity work.decode_2to4 (behavior) 
--    PORT MAP(w(1 downto 0) => w(1 downto 0), en => enable(0),y(3 downto 0) => y(3 downto 0)  );
--

end architecture structure;




