library ieee;
use ieee.std_logic_1164.all;

entity blu is 
	generic( SIZE : positive := 4 );
	port( x, y : in  std_logic_vector(SIZE-1 downto 0);
	      sel  : in  std_logic_vector(1 downto 0);
	      f    : out std_logic_vector(SIZE-1 downto 0) );
end entity blu;

architecture behavior of blu is  
begin
	with sel select
	   f <= x and y when "00",
			x or  y when "01",
			x xor y when "10",
			x nor y when others;
end architecture behavior;
