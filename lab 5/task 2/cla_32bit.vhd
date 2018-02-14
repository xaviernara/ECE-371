library ieee;
use ieee.std_logic_1164.all;

entity cla_32bit is
port (	x : in std_logic_vector(31 downto 0); --First operand
	y : in std_logic_vector(31 downto 0); --Second operand
	cin  : in std_logic; --Initial input carry
	sum  : out std_logic_vector(7 downto 0); --Sum result
	cout : out std_logic; --Final output carry
	GG : out std_logic; --32-bit group generate
	GA : out std_logic --32-bit group alive
   );
end entity cla_32bit;

--The CLA-32 comprises one or more 8-bit carry look-ahead (CLA-8) modules modules and one or more
--4-bit carry look-ahead generator (CLG-4) modules arranged and interconnected in a parallel tree
--structure. No other logic is allowed.

--In an architecture named structure, model the CLA-32 using entity instantiation statements
--and named association. Associate any unused output ports of instances with the open keyword when
--appropriate.

--architecture structure of cla_32bit is
--signal g, a : std_logic_vector(3 downto 0);
--signal c : std_logic_vector(3 downto 1);
--
--begin
--cla_8bit1: entity work.cla_8bit(structure)
--port map(x => x(7 downto 0), y => y(7 downto 0),cin => cin, sum => sum(7 downto 0),cout => open, GG => g(0), GA => a(0));
----port map(x(7 downto 0), y(7 downto 0),cin, sum(7 downto 0),open, g(0), a(0));
----port map(x(31 downto 24), y(31 downto 24),cin, sum(7 downto 0),open, g(0), a(0));
--
--cla_8bit2: entity work.cla_8bit(structure)
--port map(x => x(15 downto 8), y => y(15 downto 8),cin => c(1), sum => sum(15 downto 8),cout => open, GG => g(1), GA => a(1));
----port map(x(15 downto 8), y(15 downto 8),c(1), sum(15 downto 8),open, g(1), a(1));
----port map(x(23 downto 16), y(23 downto 16),c(1), sum(15 downto 8),open, g(1), a(1));
--
--
--cla_8bit3: entity work.cla_8bit(structure)
--port map(x => x(23 downto 16), y => y(23 downto 16),cin => c(2), sum => sum(23 downto 16),cout => open, GG => g(2), GA => a(2));
----port map(x(15 downto 8), y(15 downto 8),c(2),sum(23 downto 16),open, g(2), a(2));
--
--cla_8bit4: entity work.cla_8bit(structure)
--port map(x => x(31 downto 24), y => y(31 downto 24),cin => c(3), sum => sum(31 downto 24),cout => open, GG => g(3), GA => a(3));
----port map(x(7 downto 0), y(7 downto 0),c(3),sum(31 downto 24),open, g(3), a(3));
--
--clg_4bit1: entity work.clg_4bit(dataflow)
--port map(c0 => cin, g => g, a => a,c(4)=> cout, c(3 downto 1) => c(3 downto 1),GG => GG, GA => GA);
----port map(cin, g, a, cout, c(3 downto 1),GG, GA);
--
--end architecture structure;
--

architecture structure of cla_32bit is
signal g, a : std_logic_vector(3 downto 0);
signal c : std_logic_vector(3 downto 1);
begin
cla1: entity work.cla_8bit(structure)
port map(	x => x(7 downto 0), y => y(7 downto 0),
	cin => cin, sum => sum(7 downto 0),
	cout => open, GG => g(0), GA => a(0));

cla2: entity work.cla_8bit(structure)
port map(	x => x(15 downto 8), y => y(15 downto 8),
	cin => c(1), sum => sum(15 downto 8),
	cout => open, GG => g(1), GA => a(1));

cla3: entity work.cla_8bit(structure)
port map(	x => x(23 downto 16), y => y(23 downto 16),
	cin => c(2), sum => sum(23 downto 16),
	cout => open, GG => g(2), GA => a(2));

cla4: entity work.cla_8bit(structure)
port map(	x => x(31 downto 24), y => y(31 downto 24),
	cin => c(3), sum => sum(31 downto 24),
	cout => open, GG => g(3), GA => a(3));

clg: entity work.clg_4bit(dataflow)
port map(	c0 => cin, g => g, a => a,
	c(4)=> cout, c(3 downto 1) => c(3 downto 1),
	GG => GG, GA => GA);

end structure;

