 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity asu_golden is
  generic( SIZE : positive := 4 );
  port( x, y       : in std_logic_vector(SIZE - 1 downto 0);
        sub, arith : in std_logic;
        R          : out std_logic_vector(SIZE - 1 downto 0);
        NZVC       : out std_logic_vector(3 downto 0 ) );
end entity asu_golden;

architecture golden of asu_golden is 
   signal result_s : signed(SIZE downto 0);
   constant ZERO : signed(SIZE-1 downto 0) := (others => '0');
   signal arith_sub : std_logic_vector(1 downto 0);
begin 
   result_s <= signed('0' & x) + signed('0' & y) when sub = '0' else
               signed('0' & x) - signed('1' & y);
   R <= std_logic_vector(result_s(SIZE-1 downto 0));
   NZVC(3) <= result_s(SIZE-1) when arith = '1' else '0';
   NZVC(2) <= '1' when result_s(SIZE-1 downto 0) = ZERO else '0';
   NZVC(0) <= result_s(SIZE) and not(arith);
   arith_sub <= arith & sub;
   with arith_sub select
      NZVC(1) <= 	result_s(SIZE) XOR x(SIZE-1)  XOR  y(SIZE-1)  XOR result_s(SIZE-1) when "10",
				    result_s(SIZE) XOR (x(SIZE-1) XNOR y(SIZE-1)) XOR result_s(SIZE-1) when "11",
					'0'                                                                when others;
end architecture golden;
