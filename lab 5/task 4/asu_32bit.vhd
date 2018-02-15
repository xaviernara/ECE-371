library ieee;
use ieee.std_logic_1164.all;

entity asu_32bit is
port(	x	: in std_logic_vector(31 downto 0); --First operand
	y	: in std_logic_vector(31 downto 0); --Second Operand
	sub     : in std_logic; --Add/subtract control
	arith   : in std_logic; --Unsigned/signed control
	result	: out std_logic_vector(31 downto 0); --Sum/difference result
	NZVC	: out std_logic_vector(3 downto 0)); --Condition code flags
end entity asu_32bit;

--The ASU-32 comprises a CLA-32, a conditional inversion logic unit configured to conditionally invert
--the second operand ??, and a condition code generation unit configured to compute the (??, ??, ??, ??)
--condition code flags. When arith = 1, the condition code generation unit disables the ?? flag and
--enables the ?? flag to indicate the possible occurrence of signed (two?s complement) overflow. When
--arith = 0, the condition code generation unit disables the ?? and ?? flags and enables the ?? flag to
--indicate the possible occurrence of unsigned overflow. The condition code generation unit always
--enables the Z flag.
--

architecture mixed of asu_32bit is

signal overflow : std_logic;
signal yInversion : std_logic_vector(31 downto 0);
signal condition : std_logic_vector(31 downto 0);-- := (others => sub);

begin
condition <= (others => sub);
yInversion <= y xor condition;

NZVC(2) <= '1' when yInversion = x else '0';
NZVC(3) <= arith and result(31);
NZVC(1) <= ((y(31) xor overflow xor x(31) xor result(31)) and arith and (not sub)) or((result(31) xor overflow  xor (x(31) xnor y(31))) and arith and sub );
NZVC(0) <= overflow and (not arith);

cla32: entity work.cla_32bit(structure)
port map(x =>x, y=>yInversion, cin=>sub, sum=> result, cout=>overflow, GG=>open, GA=>open);
--port map(x, yInversion, sub, result, overflow, open,open);

end architecture mixed;

