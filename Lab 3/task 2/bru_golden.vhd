library ieee;
use ieee.std_logic_1164.all;

entity bru_golden is
	generic(SIZE : positive := 4);
	port( a    : in  std_logic_vector(SIZE-1 downto 0);
	      pass : in  std_logic;
	      y    : out std_logic_vector(SIZE-1 downto 0) );
end entity bru_golden;

architecture behavior of bru_golden is
   alias ain : std_logic_vector(0 to SIZE-1) is a;
begin
  flip : process(a, pass) is begin
		y <= a;
		if pass = '0' then 
			for i in ain'range loop
				y(i) <= ain(i);
			end loop; 
		end if;
	end process flip;
end architecture behavior;
