library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiply_8bit is
	generic
	(
		SIZE : positive := 8
	);

	port 
	(
		x,y   : in std_logic_vector(7 downto 0);
		arith	  : in std_logic;
		p         : OUT std_logic_vector(15 downto 0)
	);

end entity;
--Design the 8-bit multiplier with inputs (x, y) (8 bit operands), arith (1 bit control), and output p (16 bit product)

architecture MIXED of multiply_8bit is	
--	signal carry_out2: std_logic_vector(1 downto 0);
xy_and :std_logic_vector(0 to 15); 
xy_and2 :std_logic_vector(0 to 15); 
xy_and3 :std_logic_vector(0 to 15); 
xy_and4 :std_logic_vector(0 to 15); 
--	signal carry_out: std_logic_vector (1 downto 0);
CARRY std_logic_vector(SIZE-1 downto 0);
SUM std_logic_vector(SIZE-1 downto 0);

begin
--Model the partial product generator logic using dataflow modeling
--First 16 AND of the partial product generator logic
xy_and(0) <=  x(7) and y(7);
xy_and(1) <=  x(6) and y(7);
xy_and(2) <=  x(5) and y(7);
xy_and(3) <=  x(4) and y(7);
xy_and(4) <=  x(3) and y(7);
xy_and(5) <=  x(2) and y(7);
xy_and(6) <=  x(1) and y(7);
xy_and(7) <=  x(0) and y(7);
xy_and(8) <=  x(7) and y(6);
xy_and(9) <=  x(6) and y(6);
xy_and(10) <= x(5) and y(6);
xy_and(11) <= x(4) and y(6);
xy_and(12) <= x(3) and y(6);
xy_and(13) <= x(2) and y(6);
xy_and(14) <= x(1) and y(6);
xy_and(15) <= x(0) and y(6);

xy_and2(0) <=  x(7) and y(5);
xy_and2(1) <=  x(6) and y(5);
xy_and2(2) <=  x(5) and y(5);
xy_and2(3) <=  x(4) and y(5);
xy_and2(4) <=  x(3) and y(5);
xy_and2(5) <=  x(2) and y(5);
xy_and2(6) <=  x(1) and y(5);
xy_and2(7) <=  x(0) and y(5);
xy_and2(8) <=  x(7) and y(4);
xy_and2(9) <=  x(6) and y(4);
xy_and2(10) <= x(5) and y(4);
xy_and2(11) <= x(4) and y(4);
xy_and2(12) <= x(3) and y(4);
xy_and2(13) <= x(2) and y(4);
xy_and2(14) <= x(1) and y(4);
xy_and2(15) <= x(0) and y(4);

xy_and3(0) <=  x(7) and y(3);
xy_and3(1) <=  x(6) and y(3);
xy_and3(2) <=  x(5) and y(3);
xy_and3(3) <=  x(4) and y(3);
xy_and3(4) <=  x(3) and y(3);
xy_and3(5) <=  x(2) and y(3);
xy_and3(6) <=  x(1) and y(3);
xy_and3(7) <=  x(0) and y(3);
xy_and3(8) <=  x(7) and y(2);
xy_and3(9) <=  x(6) and y(2);
xy_and3(10) <= x(5) and y(2);
xy_and3(11) <= x(4) and y(2);
xy_and3(12) <= x(3) and y(2);
xy_and3(13) <= x(2) and y(2);
xy_and3(14) <= x(1) and y(2);
xy_and3(15) <= x(0) and y(2);

xy_and4(0) <=  x(7) and y(1);
xy_and4(1) <=  x(6) and y(1);
xy_and4(2) <=  x(5) and y(1);
xy_and4(3) <=  x(4) and y(1);
xy_and4(4) <=  x(3) and y(1);
xy_and4(5) <=  x(2) and y(1);
xy_and4(6) <=  x(1) and y(1);
xy_and4(7) <=  x(0) and y(1);
xy_and4(8) <=  x(7) and y(0);
xy_and4(9) <=  x(6) and y(0);
xy_and4(10) <= x(5) and y(0);
xy_and4(11) <= x(4) and y(0);
xy_and4(12) <= x(3) and y(0);
xy_and4(13) <= x(2) and y(0);
xy_and4(14) <= x(1) and y(0);
xy_and4(15) <= x(0) and y(0);
---------------------------------------------------------



------------------------------------------------------------
----Second 16 AND of the partial product generator logic
--xy_and2(0) <= x(3) and y(3);
--xy_and2(1) <= x(2) and y(3);
--xy_and2(2) <= x(3) and y(2);
--xy_and2(3) <= x(1) and y(3);
--
--xy_and2(4) <= x(2) and y(2);
--xy_and2(5) <= x(3) and y(1);
--xy_and2(6) <= x(0) and y(3);
--xy_and2(7) <= x(1) and y(2);
--
--xy_and2(8) <= x(2) and y(1);
--xy_and2(9) <= x(3) and y(0);
--xy_and2(10) <= x(0) and y(2);
--xy_and2(11) <= x(1) and y(1);
--
--xy_and2(12) <= x(2) and y(0);
--xy_and2(13) <= x(0) and y(1);
--xy_and2(14) <= x(1) and y(0);
--xy_and2(15) <= x(0) and y(0);


--
--full_adder1:entity work.full_adder<dataflow>
--port map (cin<='0', x<=x(1), y<=y(1), sum<=sum, cout<=carry_out(1);
--
--
--
--full_adder2:entity work.full_adder<dataflow>
--port map(x<=x(0), y<=y(0), cin<='0', sum<=sum, cout<=carry_out(1);
--
--
--full_adder3:entity work.full_adder<dataflow>
--port map(x<=w(1), y<=z(1), cin<='1', sum<=sum, cout<=carry_out2(1));
--
--
--full_adder4:entity work.full_adder<dataflow>
--port map(x<=w(0), y<=z(0), cin<='1', sum<=sum, cout<=carry_out2(0));
--
-------------------------------------------------------------------------------
--
--
--mux1: entity work mux2to1 <mixed>
--port map (w0<=carry_out(1),w1<=carry_out2(1), s<=cin(1), f<=cout);
--
--
--mux2: entity work mux2to1 <mixed>
--port map (w0<=carry_out(0),w1<=carry_out2(0), s<=cin(0), f<=cout);
--
--
--mux3: entity work mux2to1 <mixed>
--port map (w0<='0',w1<='1', s<=arith, f<=cout);









end architecture mixed;

