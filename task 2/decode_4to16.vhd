library ieee;
use ieee.std_logic_1164.all;

entity decode_4to16 is 
   port( w  : in  std_logic_vector(3 downto 0); --Binary address
	 en : in  std_logic; --Active high output enable
	 y  : out  std_logic_vector(15 downto 0) --One-hot address
  );
end entity decode_4to16;

--In an architecture named mixed, model the 4-to-16 binary address decoder according to the
--following modeling guidelines:

--Use entity instantiation statements to structurally model the 3-to-8 and 1-to-2 binary address
--decoders.
--
--Use a combination of for?generate and simple concurrent signal assignment statements to
--model any additional combination logic.
--
--Use constant objects and integer multiplication for vector indexing/slicing when appropriate.


architecture mixed of decode_4to16 is 

--signal wy : std_logic_vector(15 downto 0);
 signal wy_1 : std_logic_vector(7 downto 0);
 signal wy_2 : std_logic_vector(1 downto 0);
 
 
begin

--	decoder_3to8 : entity work.decode_3to8(structure)
--	--PORT MAP(w => w(3 downto 1), en => en, y=> y(i downto 8) );
--	PORT MAP(w => w(3 downto 1), en => en, y=> wy(9 downto 2) );
--
--	decoder_1to2 : entity work.decode_1to2(behavior)
--	--PORT MAP(w => w(3 downto 1), en => en, y=> y(i downto 5) );
--	 PORT MAP(w => w(0), en => en, y=> wy(1 downto 0) );


decoder_3to8 : entity work.decode_3to8(structure)
       --PORT MAP(w => w(3 downto 1), en => en, y=> y(i downto 8) );
	PORT MAP(w => w(3 downto 1), en => en, y=> wy_1(7 downto 0) );

	decoder_1to2 : entity work.decode_1to2(behavior)
	--PORT MAP(w => w(3 downto 1), en => en, y=> y(i downto 5) );
	 PORT MAP(w => w(0), en => en, y=> wy_2(1 downto 0) );

	--y(i)<= wy(i) and wy(i downto i-1);
	--y(i)<=wy(i downto i-1) and wy(i);
	--y(i)<=wy_1(i downto i-1) and wy_2(i);
	--wy <= w(i) and y(i);

combo_logic_level1 : for COL in 0 to 7 generate
	combo_logic_level2 : for ROW in 0 to 1 generate
	
		y(COL+1)<=wy_1(COL) and wy_2(ROW);
  --y(i)<= wy_1(i) and wy_2(i);
	
	end generate combo_logic_level2;
end generate combo_logic_level1;

	
end architecture mixed;


	
	  