library ieee;
use ieee.std_logic_1164.all;

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

  y <= x when "000" else
       x when "001" else
       x when "010" else
       x
	 
