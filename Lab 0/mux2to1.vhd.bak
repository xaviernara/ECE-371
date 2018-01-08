library ieee;
use ieee.std_logic_1164.all;

entity mux2_to1 is 
   port(w0,w1,s : in std_logic;
	f : out std_logic
	);
end entity mux2_to1;
architecture dataflow of mux2_to1 is
	SIGNAL  a,b : std_logic;

begin 
 a <= (not (s) and w0);
 b <= s and w1;
 f <= a or b;

end architecture dataflow;

	


	
