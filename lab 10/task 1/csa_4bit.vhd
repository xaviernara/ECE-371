library ieee;
use ieee.std_logic_1164.all;

entity csa_4bit is

	generic
	(
		SIZE : positive := 3
	);

	port 
	(
		--x,y,w,z   : in std_logic_vector(SIZE-1 downto 0);  
		x,y,w,z   : in std_logic; 
		CIN       : in std_logic;
		--carry,sum : out std_logic_vector(SIZE-1 downto 0);
		carry,sum : out std_logic;
	   COUT      : OUT std_logic
	);

end entity;

--Design an n-bit, 4:2 CSA (compressor) structurally using several (3, 2) counters.  
--The n-bit operand inputs are (w, x, y, z), the 1-bit transfer input is tin, the n-bit carry-save 
--and sum vectors are (c, s), and the 1-bit transfer output

architecture structure of csa_4bit is

--signal sum_out : std_logic_vector(SIZE-1 downto 0);
--type adder_wire is array (1 downto 0 ) of std_logic;

--signal CARRY_save: std_logic_vector(SIZE-3 downto 0);
--signal SUM : std_logic_vector(SIZE-3 downto 0);
--signal CARRY_save: std_logic;
--signal SUM : std_logic;

signal sum_out : std_logic; --intermediate signal connecting the sum output of the 1st FA to the 2nd
--
constant N: integer:= 4;

begin 
--
----sum_out<=sum

--full_adder1: entity work.full_adder(dataflow)
----GENERIC MAP (SIZE => SIZE) 
--port map (cin => w, x=> x, y=> y, sum=> sum_out, cout=> cout);
--
--
--full_adder2: entity work.full_adder(dataflow)
----GENERIC MAP (SIZE => SIZE) 
--port map(x =>sum_out, y => z, cin => cin, sum=> sum, cout=> carry);
--
----	full_adder_gen:for i in 0 to SIZE-2 generate
----
----		full_adder1: entity work.full_adder(dataflow)
----		--GENERIC MAP (SIZE => SIZE) 
----		port map (cin => w(i), x=> x(i), y=> y(i), sum=> sum_out, cout=> cout(i));
----
----		full_adder2: entity work.full_adder(dataflow)
----		--GENERIC MAP (SIZE => SIZE) 
----		port map(x =>sum_out, y => z(i), cin => cin(i), sum=> sum(i), cout=> carry(i));
----
----	end generate full_adder_gen;

	--full_adder_gen:for i in 0 to N-2 generate

		full_adder1: entity work.combo_count_32(behavior) 
		--port map (cin => w(i), x=> x(i), y=> y(i), sum=> sum_out, cout=> cout(i));
		--port map (x(2)=> x(i), x(1)=>y(i), x(0)=>w(i), y(1)=>cout(i), y(0)=> sum_out(i)); 
		port map (x(2)=> x, x(1)=>y, x(0)=>w, y(1)=>cout, y(0)=> sum_out); 
		
		full_adder2: entity work.combo_count_32(behavior)
		--port map(x =>sum_out, y => z(i), cin => cin(i), sum=> sum(i), cout=> carry(i));
		--port map (x(2)=> z(i), x(1)=>sum_out(i), x(0)=>cin(i), y(1)=>CARRY_save(i), y(0)=> sum(i)); 
		port map (x(2)=> z, x(1)=>sum_out, x(0)=>cin, y(1)=>CARRY, y(0)=>sum); 
		
	--end generate full_adder_gen;



end architecture structure;

