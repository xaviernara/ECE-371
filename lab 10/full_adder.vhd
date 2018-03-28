library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
   port ( cin, x, y : in  std_logic;
          cout, sum : out std_logic );
end entity full_adder;

architecture dataflow of full_adder is
   signal g, p : std_logic;
begin
	g <= x and y;
	p <= x xor y;
	sum <= p xor cin;
	cout <= g or (p and cin); 
end architecture dataflow;
