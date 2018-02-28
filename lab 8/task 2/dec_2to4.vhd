library ieee;
use ieee.std_logic_1164.all;

entity dec_2to4 is 
	port( w  : in  std_logic_vector(1 downto 0);
	      en : in  std_logic;
	      y  : out  std_logic_vector(3 downto 0) );
end entity dec_2to4;

architecture behavior of dec_2to4 is 
   signal enw : std_logic_vector(2 downto 0);
begin
    enw <= en & w;
	with enw select
       y <= "0001"           when "100",
			   "0010"           when "101",
			   "0100"           when "110",
			   "1000"           when "111",
			   "0000"		     when others;
end architecture behavior;
