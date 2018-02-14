library ieee;
use ieee.std_logic_1164.all;

entity csla is
generic(NUM_GROUPS : positive := 2); --Number of 8-bit groups
port(	x	: in std_logic_vector(8*NUM_GROUPS - 1 downto 0);--First operand
	y	: in std_logic_vector(8*NUM_GROUPS - 1 downto 0);--Second operand
	cin	: in std_logic; --Initial input carry
	sum	: out std_logic_vector(8*NUM_GROUPS - 1 downto 0); --Sum result
	cout	: out std_logic --Final output carry
);
end entity  csla;

--The generic (8·NUM_GROUPS)-bit CSLA comprises (2·NUM_GROUPS)-1 CLA-8 adders, (NUM_GROUPS1)
--8-bit 2-to-1 multiplexers, and NUM_GROUPS-1 1-bit 2-to-1 multiplexers. No other logic is allowed.
--
--In an architecture named structure, model the generic CSLA using entity instantiation
--statements with named association, generate statements, and a vector-of-vector type declaration.
--
architecture structure of csla is
type selecter_type is array(2 to NUM_GROUPS) of std_logic_vector(7 downto 0);
signal sel1, sel0 : selecter_type;
signal c, c1, c0: std_logic_vector(NUM_GROUPS downto 1);
begin
cla_8_1: entity work.cla_8bit(structure)
	port map(x => x(7 downto 0),y => y(7 downto 0),cin => cin, sum => sum(7 downto 0),cout => c(1), GG => open, GA => open);

cla: for i in 2 to NUM_GROUPS generate
cla_8bit1: entity work.cla_8bit(structure)
	port map(x => x((i*8)-1 downto (i-1)*8),y => y((i*8)-1 downto (i-1)*8),cin => '1', sum => sel1(i),cout => c1(i-1), GG => open, GA => open);

cla_8bit2: entity work.cla_8bit(structure)
	port map(x => x((i*8)-1 downto (i-1)*8),y => y((i*8)-1 downto (i-1)*8),cin => '0', sum => sel0(i),cout => c0(i-1), GG => open, GA => open);

mux_carry: entity work.mux_2to1(mixed)
	generic map (SIZE => 1)
	port map (w0 => c0(i-1 downto i-1),w1 => c1(i-1 downto i-1),s => c(i-1), f => c(i downto i));

mux_ans: entity work.mux_2to1(mixed)
	generic map (SIZE => 8)
	port map (w0 => sel0(i), w1 => sel1(i),s => c(i-1), f => sum((i*8)-1 downto (i-1)*8));

end generate;

last_carry: entity work.cla_8bit(structure)
	port map(x => x((NUM_GROUPS*8)-1 downto (NUM_GROUPS-1)*8),y => y((NUM_GROUPS*8)-1 downto (NUM_GROUPS-1)*8),cin => c(NUM_GROUPS), sum => open,cout => cout, GG => open, GA => open); 
end structure;
