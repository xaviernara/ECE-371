library ieee;
use ieee.std_logic_1164.all;

entity cla_8bit is
port (	x : in std_logic_vector(7 downto 0); --First operand
	y : in std_logic_vector(7 downto 0); --Second operand
	cin  : in std_logic; --Initial input carry
	sum  : out std_logic_vector(7 downto 0); --Sum result
	cout : out std_logic; --Final output carry
	GG : out std_logic; --8-bit group generate
	GA : out std_logic --8-bit group alive
   );
end entity cla_8bit;

--The CLA-8 comprises one or more 2-bit carry look-ahead adders (CLA-2) and one or more carry lookahead
--generator (CLG-2) modules arranged in a parallel tree structure. No other logic is allowed.
--
--In an architecture named structure, model the CLA-8 using component declaration and
--component instantiation statements and named association. Associate any unused output ports of
--instances with the open keyword when appropriate.
--

architecture structure of cla_8bit is
signal g, a : std_logic_vector(3 downto 0);
signal carries : std_logic_vector(3 downto 1);
signal gen, alive : std_logic_vector(1 downto 0);

begin
----------------------------------------------------------------------------
--CLA_2BIT logic
----------------------------------------------------------------------------
cla_2bit1: entity work.cla_2bit(mixed)
port map(x => x(1 downto 0), y => y(1 downto 0),cin => cin, sum => sum(1 downto 0),cout => open, GG => g(0), GA => a(0));

cla_2bit2: entity work.cla_2bit(mixed)
port map(x => x(3 downto 2), y => y(3 downto 2),cin => carries(1), sum => sum(3 downto 2),cout => open, GG => g(1), GA => a(1));

cla_2bit3: entity work.cla_2bit(mixed)
port map(x => x(5 downto 4), y => y(5 downto 4),cin => carries(2), sum => sum(5 downto 4),cout => open, GG => g(2), GA => a(2));

cla_2bit4: entity work.cla_2bit(mixed)
port map(x => x(7 downto 6), y => y(7 downto 6),cin => carries(3), sum => sum(7 downto 6),cout => open, GG => g(3), GA => a(3));

----------------------------------------------------------------------------
--CLG_2BIT logic
----------------------------------------------------------------------------
clg_2bit1: entity work.clg_2bit(dataflow)
port map(g => g(1 downto 0), a => a(1 downto 0),cin => cin, carries => carries(2 downto 1),GG => gen(0), GA => alive(0));

clg_2bit2: entity work.clg_2bit(dataflow)
port map(g => g(3 downto 2), a => a(3 downto 2),cin => carries(2),carries(2) => cout, carries(1) => carries(3),GG => gen(1), GA => alive(1));

clg_2bit3: entity work.clg_2bit(dataflow)
port map(g => gen, a => alive,cin => cin, carries => open, GG => GG, GA => GA);


end architecture structure;
