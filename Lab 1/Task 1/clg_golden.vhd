library ieee;        
use ieee.std_logic_1164.all;

entity clg_golden is
	generic( SIZE : positive := 2 );
	port( c0     : in std_logic;
	      g, p   : in std_logic_vector(SIZE-1 downto 0);
	      c      : out std_logic_vector(SIZE downto 1);
	      GG, GP : out std_logic );
end entity clg_golden;

architecture behavior of clg_golden is
   signal group_prop : std_logic_vector(SIZE-1 downto 0);
   signal group_gen : std_logic_vector(SIZE-1 downto 0);
begin
  
	cgen : for i in 1 to SIZE generate
	   c(i) <= group_gen(i-1) or (group_prop(i-1) and c0);
	end generate cgen;

	group_prop(0) <= p(0);
	GP <= group_prop(SIZE-1);
	grp_prop_gen : for i in 1 to SIZE-1 generate
	   group_prop(i) <= group_prop(i-1) and p(i);
	end generate grp_prop_gen;

	group_gen(0) <= g(0);
	GG <= group_gen(SIZE-1);
	grp_gen_gen : for i in 1 to SIZE-1 generate
	   group_gen(i) <= g(i) or (p(i) and group_gen(i-1));
	end generate grp_gen_gen;
	
end architecture behavior;
