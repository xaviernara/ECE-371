library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pride_alu_behave is
generic(LOG2_SIZE : positive := 3);
port(	x, y 	: in std_logic_vector(2**LOG2_SIZE-1 downto 0);
	funct	: in std_logic_vector(3 downto 0);
	result	: out std_logic_vector(2**LOG2_SIZE-1 downto 0);
	NZVC	: out std_logic_vector(3 downto 0));
end pride_alu_behave;

architecture behavior of pride_alu_behave is
type results_type is array(0 to 12) of std_logic_vector(2**LOG2_SIZE-1 downto 0);
type flags_type is array(0 to 12) of std_logic_vector(3 downto 0);
signal results : results_type;
signal flags   : flags_type;

constant FUNCT_AND : std_logic_vector(3 downto 0) := "0000";
constant FUNCT_OR : std_logic_vector(3 downto 0) := "0001";
constant FUNCT_XOR : std_logic_vector(3 downto 0) := "0010";
constant FUNCT_NOR : std_logic_vector(3 downto 0) := "0011";
constant FUNCT_UADD : std_logic_vector(3 downto 0) := "0100";
constant FUNCT_SADD : std_logic_vector(3 downto 0) := "0101";
constant FUNCT_USUB : std_logic_vector(3 downto 0) := "0110";
constant FUNCT_SSUB : std_logic_vector(3 downto 0) := "0111";
constant FUNCT_USLT : std_logic_vector(3 downto 0) := "1010";
constant FUNCT_SSLT : std_logic_vector(3 downto 0) := "1011";
constant FUNCT_SLL : std_logic_vector(3 downto 0) := "1100";
constant FUNCT_SRL : std_logic_vector(3 downto 0) := "1110";
constant FUNCT_SRA : std_logic_vector(3 downto 0) := "1111";

begin
results(0) <= x and y;
results(1) <= x or y;
results(2) <= x xor y;
results(3) <= x nor y;
-------------------------------------------------------
flags(0) <= (2 => not(or results(0)), others => '0');
flags(1) <= (2 => not(or results(1)), others => '0');
flags(2) <= (2 => not(or results(2)), others => '0');
flags(3) <= (2 => not(or results(3)), others => '0');
--------------------------------------------------------
results(4) <= std_logic_vector(unsigned(x) + unsigned(y));
results(5) <= std_logic_vector(signed(x) + signed(y));
results(6) <= std_logic_vector(unsigned(x) - unsigned(y));
results(7) <= std_logic_vector(signed(x) - signed(y));
----------------------------------------------------------
flags(4) <= (2 => not(or results(4)),
	     0 => (x(2**LOG2_SIZE-1) and y(2**LOG2_SIZE-1)) or
	    ((x(2**LOG2_SIZE-1) xor y(2**LOG2_SIZE-1)) and not results(4)(2**LOG2_SIZE-1)),
	    others => '0');
flags(5) <= (3 => results(5)(2**LOG2_SIZE-1), 2 => not(or results(5)),
	     1 =>  (x(2**LOG2_SIZE-1) and y(2**LOG2_SIZE-1) and not results(5)(2**LOG2_SIZE-1)) or
	     (not x(2**LOG2_SIZE-1) and not y(2**LOG2_SIZE-1) and results(5)(2**LOG2_SIZE-1)),
	     0 => '0');
flags(6) <=  (2 => not(or results(6)),
	     0 => ((x(2**LOG2_SIZE-1) xnor y(2**LOG2_SIZE-1)) and not results(6)(2**LOG2_SIZE-1)) or
	     (x(2**LOG2_SIZE-1) and not y(2**LOG2_SIZE-1)),
	     others => '0');
flags(7) <= (3 => results(7)(2**LOG2_SIZE-1), 2 => not(or results(7)),
	     1 =>  (not x(2**LOG2_SIZE-1) and y(2**LOG2_SIZE-1) and results(7)(2**LOG2_SIZE-1)) or
	     (x(2**LOG2_SIZE-1) and not y(2**LOG2_SIZE-1) and not results(7)(2**LOG2_SIZE-1)),
	      0 => '0');
----------------------------------------------------------------------------
results(8) <= (0 => '1', others => '0') when unsigned(x) < unsigned(y) else
	     (others => '0');

results(9) <= (0 => '1', others => '0') when signed(x) < signed(y) else
	     (others => '0');

flags(8) <= (2 => not(or results(8)), others => '0');
flags(9) <= (2 => not(or results(9)), others => '0');

results(10) <= std_logic_vector(unsigned(y) sll to_integer(unsigned(x(LOG2_SIZE-1 downto 0))));
results(11) <= std_logic_vector(unsigned(y) srl to_integer(unsigned(x(LOG2_SIZE-1 downto 0))));
results(12) <= std_logic_vector(SHIFT_RIGHT(signed(y), to_integer(unsigned(x(LOG2_SIZE-1 downto 0)))));
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
end behavior;
