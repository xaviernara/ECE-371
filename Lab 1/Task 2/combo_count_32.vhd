library ieee;
use ieee.std_logic_1164.all;
use ieee.math_complex.all;
use ieee.MATH_COMPLEX.all;


entity combo_count_32 is 
    port(
	x  : in std_logic_vector(2 downto 0); --Data operand
	y : out  std_logic_vector(1 downto 0); --Number of 1?s in data operand x
   );
end entity;

--In an architecture named behavior, utilize a single concurrent conditional signal assignment
--(CCSA) statement to model the (??, ??) = (3, 2) combinational counter. Attempt to minimize the
--number of lines of code you write.

architecture behavior of combo_count_32 is
  signal p :std_logic_vector(2 downto 0);
  signal q : std_logic_vector(2 downto 0);
	    
begin
 q(p)<= ceiling (log2*(p + 1)); 

  y <= "00" when x = "000" else,
       "01" when x = "001" else,
       "11" when x = "001" else,
       "10" when others;
	 
