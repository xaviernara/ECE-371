library ieee;
use ieee.std_logic_1164.all;

entity dec_3to8 is
	port( w  : in  std_logic_vector(2 downto 0);
	      en : in  std_logic;
	      y  : out  std_logic_vector(7 downto 0) );
end entity dec_3to8;

architecture behavior of dec_3to8 is
   signal en_w : std_logic_vector(3 downto 0);
begin
	en_w <= en & w;
	with en_w select
		y <= x"01" when "1000",
 		     x"02" when "1001",
		     x"04" when "1010",
		     x"08" when "1011",
		     x"10" when "1100",
		     x"20" when "1101",
		     x"40" when "1110",
		     x"80" when "1111",
		     x"00" when others;
end architecture behavior;
