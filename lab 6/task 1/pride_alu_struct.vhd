library ieee;
use ieee.std_logic_1164.all;

entity pride_alu_struct is
port(	x : in std_logic_vector(31 downto 0); --First operand
	y : in std_logic_vector(31 downto 0); --Second operand
	funct : in std_logic_vector(3 downto 0); --ALU control
	result : out std_logic_vector(31 downto 0); --Result
	NZVC : out std_logic_vector(3 downto 0)); --Condition code flags
end entity pride_alu_struct;

architecture structure of pride_alu_struct is

type results_type is array(0 to 12) of std_logic_vector(31 downto 0);
type flags_type is array(0 to 12) of std_logic_vector(3 downto 0);
signal results : results_type;
signal flags   : flags_type;
signal compA, compB  : std_logic_vector(2 downto 0);
--signal result :std_logic_vector(31 downto 0);

begin

--result<= result;

blu_0: entity work.blu(behavior)
generic map(32)
	port map(x, y, "00", results(0));

blu_1: entity work.blu(behavior)
generic map(32)
	port map(x, y, "01", results(1));

blu_2: entity work.blu(behavior)
generic map(32)
	port map(x, y, "10", results(2));

blu_3: entity work.blu(behavior)
generic map(32)
	port map(x, y, "11", results(3));
	flags(0) <= (2 => not(or results(0)), others => '0');
	flags(1) <= (2 => not(or results(1)), others => '0');
	flags(2) <= (2 => not(or results(2)), others => '0');
	flags(3) <= (2 => not(or results(3)), others => '0');

asu_32bit_1: entity work.asu_32bit(mixed)
	port map(x, y, '0', '0', results(4), flags(4));

asu_32bit_2: entity work.asu_32bit(mixed)
	port map(x, y, '0', '1', results(5), flags(5));

asu_32bit_3: entity work.asu_32bit(mixed)
	port map(x, y, '1', '0', results(6), flags(6));
asu_32bit_4: entity work.asu_32bit(mixed)
	port map(x, y, '1', '1', results(7), flags(7));

scu_1: entity work.scu(mixed)
	port map(flags(6), '0', compA);

scu_2: entity work.scu(mixed)
	port map(flags(7), '1', compB);
	results(8) <= (0 => compA(1), others => '0');
	results(9) <= (0 => compB(1), others => '0');
	flags(8) <= (2 => not compA(1), others => '0');
	flags(9) <= (2 => not compB(1), others => '0');

log_bsru_1: entity work.log_bsru(structure)
	generic map(5)
	port map(y, x(4 downto 0), '1', '0', '0', results(10));
log_bsru_2: entity work.log_bsru(structure)
	generic map(5)
	port map(y, x(4 downto 0), '1', '1', '0', results(11));
log_bsru_3: entity work.log_bsru(structure)
	generic map(5)
	port map(y, x(4 downto 0), '1', '1', '1', results(12));
	flags(10) <= (2 => not(or results(10)), others => '0');
	flags(11) <= (2 => not(or results(11)), others => '0');
	flags(12) <= (2 => not(or results(12)), others => '0');

with funct select
	result <= results(0) when "0000",results(1) when "0001",
		  results(2) when "0010",results(3) when "0011",
		  results(4) when "0100",results(5) when "0101",
		  results(6) when "0110",results(7) when "0111",
		  results(8) when "1010",results(9) when "1011",
		  results(10) when "1100",results(11) when "1110",
		  results(12) when others;
with funct select
	  NZVC <= flags(0) when "0000",flags(1) when "0001",
		  flags(2) when "0010",flags(3) when "0011",
		  flags(4) when "0100",flags(5) when "0101",
		  flags(6) when "0110",flags(7) when "0111",
		  flags(8) when "1010",flags(9) when "1011",
		  flags(10) when "1100",flags(11) when "1110",
		  flags(12) when others;
end architecture structure;

