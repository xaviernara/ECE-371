library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is
	generic( SIZE : positive := 4 );
	port( w0    : in  std_logic_vector(SIZE-1 downto 0);
	      w1    : in  std_logic_vector(SIZE-1 downto 0);
	      w2    : in  std_logic_vector(SIZE-1 downto 0);
	      w3    : in  std_logic_vector(SIZE-1 downto 0);
	      w4    : in  std_logic_vector(SIZE-1 downto 0);
	      w5    : in  std_logic_vector(SIZE-1 downto 0);
	      w6    : in  std_logic_vector(SIZE-1 downto 0);
	      w7    : in  std_logic_vector(SIZE-1 downto 0);
		  sel   : in  std_logic_vector(2 downto 0);
	      f     : out std_logic_vector(SIZE-1 downto 0) );
end entity mux_8to1;

architecture behavior of mux_8to1 is
begin
	with sel select
		f <= w0              when "000",
			 w1              when "001",
			 w2              when "010",
			 w3              when "011",
			 w4              when "100",
			 w5              when "101",
			 w6              when "110",
			 w7              when "111",
			 (others => '-') when others;
end architecture behavior;
