library ieee;
use ieee.std_logic_1164.all;

entity right_fsru is
generic ( SIZE : positive := 4; --Operand bit-width
	  CNT_VAL : positive :=1);--Fixed shift/rotate count value

port (	A	: in std_logic_vector(SIZE-1 downto 0); --Operand to shift/rotate
	en	: in std_logic; --Shift/rotate enable
	shift	: in std_logic; --Shift/rotate control
	srin	: in std_logic; --Bit-value replacing vacant bit positions
	F	: out std_logic_vector(SIZE-1 downto 0)); --Shifted/rotated operand
end right_fsru;

architecture mixed of right_fsru is

signal x, z : std_logic_vector(CNT_VAL-1 downto 0);
signal y : std_logic_vector(SIZE-1 downto CNT_VAL);

begin
--simple signal assignment
x <= (others => srin);
y <= A(SIZE-1 downto CNT_VAL);

--instantiation
toplevel_mux : entity work.mux_2to1(mixed)
	generic map(CNT_VAL)
	port map(A(CNT_VAL-1 downto 0), x, shift, z);

with en select
	F <= z & y when '1', 
	     A when others;

end architecture mixed;
