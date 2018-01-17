library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use work.data_types.all;

entity mux_golden is
  generic( M : positive := 2;  --data bus size
           N : positive := 4 );--number of input data busses
  port( data_matrix : in  matrix(0 to N-1, M-1 downto 0);
--      en          : in  std_logic;
        s           : in  std_logic_vector( positive(ceil(log2(real(N))))-1 downto 0);
        f           : out std_logic_vector(M-1 downto 0) );
end entity mux_golden;

architecture behavior of mux_golden is
  signal s_int : natural range 0 to N-1;
begin
   s_int <= to_integer(unsigned(s));
   mux_bits : for i in 0 to M-1 generate
       f(i) <= data_matrix(s_int, i);-- and en;
  end generate mux_bits;
end architecture behavior;
