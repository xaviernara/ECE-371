library ieee;
use ieee.std_logic_1164.all;

entity clg_2bit is
	port( g, a   : in  std_logic_vector(1 downto 0);   
	      cin    : in  std_logic;   
		  carries: out std_logic_vector(2 downto 1 ); 
          GG, GA : out std_logic ); 
end entity clg_2bit;

architecture dataflow of clg_2bit is
   signal GGint, GAint : std_logic;

begin
	carries(1) <= g(0) or (a(0)and cin);
	carries(2) <= GGint or (GAint and cin);  --this is the output carry

	GG <= GGint;
	GA <= GAint;
	GGint <= g(1) or (a(1) and g(0));
	GAint <= a(1) and a(0);
end architecture dataflow;
