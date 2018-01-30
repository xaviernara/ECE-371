<<<<<<< HEAD
library ieee;
use ieee.std_logic_1164.all;

entity decode_2to4 is 
	port( w  : in  std_logic_vector(1 downto 0);
	      en : in  std_logic;
	      y  : out  std_logic_vector(3 downto 0) );
end entity decode_2to4;

architecture behavior of decode_2to4 is 
   signal enw : std_logic_vector(2 downto 0);
begin
    enw <= en & w;
	with enw select
       y <= 4x"1"           when 3x"4",
			4x"2"           when 3x"5",
			4x"4"           when 3x"6",
			4x"8"           when 3x"7",
			(others => '0') when others;
end architecture behavior;
=======
library ieee;
use ieee.std_logic_1164.all;

entity decode_2to4 is 
	port( w  : in  std_logic_vector(1 downto 0);
	      en : in  std_logic;
	      y  : out  std_logic_vector(3 downto 0) );
end entity decode_2to4;

architecture behavior of decode_2to4 is 
   signal enw : std_logic_vector(2 downto 0);
begin
    enw <= en & w;
	with enw select
       y <= 4x"1"           when 3x"4",
			4x"2"           when 3x"5",
			4x"4"           when 3x"6",
			4x"8"           when 3x"7",
			(others => '0') when others;
end architecture behavior;
>>>>>>> 5e6ea64a5fd18b0da54a6bdcdd8534fa87e3ee05
