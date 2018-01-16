library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity combo_count_golden is
	generic ( P : positive := 4);
	port( x : in std_logic_vector(P-1 downto 0);
	      y : out std_logic_vector( positive(ceil(log2(real(P+1))))-1 downto 0)
		);
end entity combo_count_golden;

architecture behavior of combo_count_golden is
begin
	counter : process(x) is 
	   variable cnt : unsigned( positive(ceil(log2(real(P+1))))-1 downto 0);
	begin
	  cnt := (others => '0');
		for i in 0 to P-1 loop
			if x(i) = '1' then 
			   cnt := cnt + 1;
			end if;
		end loop;
		y <= std_logic_vector(cnt);
	end process counter;	
end architecture behavior;
