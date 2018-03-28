library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiply_4bit is
	generic
	(
		SIZE : positive := 8
	);

	port 
	(
		x,y   : in std_logic_vector(3 downto 0);
		arith	  : in std_logic;
		p         : OUT std_logic_vector(15 downto 0)
	);

end entity;
--Design the 8-bit multiplier with inputs (x, y) (8 bit operands), arith (1 bit control), and output p (16 bit product)

architecture MIXED of multiply_4bit is	
--	signal carry_out2: std_logic_vector(1 downto 0);
signal xy_and :std_logic_vector(0 to 15); 
--xy_and2 :std_logic_vector(15 downto 0); 
--	signal carry_out: std_logic_vector (1 downto 0);
signal HA_cout, HA_sum :std_logic_vector(1 downto 0); 
signal FA_cout, FA_sum :std_logic;
signal CSA_cout, CSA_sum :std_logic(5 downto 0);;


begin
--Model the partial product generator logic using dataflow modeling
--16 AND of the partial product generator logic for 4 bit multiplier
xy_and(0) <= x(3) and y(3);
xy_and(1) <= x(2) and y(3);
xy_and(2) <= x(3) and y(2);
xy_and(3) <= x(1) and y(3);

xy_and(4) <= x(2) and y(2);
xy_and(5) <= x(3) and y(1);
xy_and(6) <= x(0) and y(3);
xy_and(7) <= x(1) and y(2);
----------------------------------
xy_and(8) <= x(2) and y(1);
xy_and(9) <= x(3) and y(0);
xy_and(10) <= x(0) and y(2);
xy_and(11) <= x(1) and y(1);

xy_and(12) <= x(2) and y(0);
xy_and(13) <= x(0) and y(1);
xy_and(14) <= x(1) and y(0);
xy_and(15) <= x(0) and y(0);
-----------------------------------
-----------------------------------

half_adder1: entity work.half_adder(dataflow)
--GENERIC MAP (SIZE => SIZE) 
port map (A=> xy_and(0), B=>FA_cout, sum=> HA_sum(1), cout=> HA_cout(1));


full_adder1: entity work.full_adder(dataflow)
--GENERIC MAP (SIZE => SIZE) 
port map (cin => CSA_cout(5), x=> xy_and(1), y=> xy_and(2), sum=> FA_sum, cout=>FA_cout);

carry_adder1: entity work.csa_4bit(structure)
--GENERIC MAP (SIZE => SIZE) 
port map (cin => CSA_cout(5), x=> xy_and(1), y=> xy_and(2), sum=> FA_sum, cout=>FA_cout);




full_adder2: entity work.full_adder(dataflow)
--GENERIC MAP (SIZE => SIZE) 
port map(x =>sum_out, y => z, cin => cin, sum=> sum, cout=> carry);