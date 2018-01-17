library ieee;
use ieee.std_logic_1164.all;


entity combo_count_94 is 
    port(
	x1  : in std_logic_vector(8 downto 0); --Data operand
	y1 : out  std_logic_vector(3 downto 0) --Number of 1?s in data operand x
   );
end entity;
--The (p,q) = (9, 4) combinational counter comprises only several (p,q) = (3, 2) combinational
--counters. In an architecture named structure, use several entity instantiation statements and
--named association to describe the interconnection of the several instances of (p,q) = (3, 2)
--combinational counters. When applicable, associate any unused output ports of instances to the
--open keyword and/or use the concatenation (&) operator.


architecture structure of combo_count_94 is
  signal p :std_logic_vector(1 downto 0);
  --signal q : std_logic_vector(2 downto 0);
	    
begin
 
combo1: entity work.combo_count_32 (behavior) 
	   --PORT MAP(x(2 downto 0) => x(8 downto 6), y(1) =>p(1)); 
      	  PORT MAP(x => x1(8 downto 6), y =>y1(3)); 

combo2: entity work.combo_count_32 (behavior) 
	  --PORT MAP(x(2 downto 0) => x(5 downto 3), y(1) =>p(0)); 
      	  PORT MAP(x => x1(5 downto 3), y =>y1(2)); 

combo3: entity work.combo_count_32 (behavior) 
	   --PORT MAP(x(2 downto 0) => x(2 downto 0), y(1) =>open); 
	  PORT MAP(x => x1(2 downto 0), y =>y1(1)); 
      
combo4: entity work.combo_count_32 (behavior) 
	   --PORT MAP(x(2 downto 0) => x(2 downto 0), y(1) =>open); 
	  PORT MAP(x => x1(2 downto 0), y =>y1(0));       
      
end architecture structure;
