library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1 is
	generic( SIZE : positive := 4 );
	port( w0    : in  std_logic_vector(SIZE-1 downto 0);
	      w1    : in  std_logic_vector(SIZE-1 downto 0);
		  sel   : in  std_logic;
	      f     : out std_logic_vector(SIZE-1 downto 0) );
end entity mux_2to1;

architecture behavior of mux_2to1 is
begin
	with sel select
		f <= w0              when '0',
			 w1              when '1',
			 (others => '-') when others;
end architecture behavior;
