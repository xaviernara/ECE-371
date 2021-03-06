
library ieee;
use ieee.std_logic_1164.all;

entity decode_1to2 is 
	port( w  : in  std_logic;
	      en : in  std_logic;
	      y  : out  std_logic_vector(1 downto 0) );
end entity decode_1to2;

architecture behavior of decode_1to2 is 
   signal enw : std_logic_vector(1 downto 0);
begin
    enw <= en & w;
	with enw select
       y <= 2x"1"           when 2x"2",
			2x"2"           when 2x"3",
			(others => '0') when others;
end architecture behavior;

library ieee;
use ieee.std_logic_1164.all;

entity decode_1to2 is 
	port( w  : in  std_logic;
	      en : in  std_logic;
	      y  : out  std_logic_vector(1 downto 0) );
end entity decode_1to2;

architecture behavior of decode_1to2 is 
   signal enw : std_logic_vector(1 downto 0);
begin
    enw <= en & w;
	with enw select
       y <= 2x"1"           when 2x"2",
			2x"2"           when 2x"3",
			(others => '0') when others;
end architecture behavior;

