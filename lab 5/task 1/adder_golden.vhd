library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_golden is
  generic( SIZE : positive := 3 );
  port( x, y : in std_logic_vector(SIZE - 1 downto 0);
        Cin  : in std_logic;
        Cout : out std_logic;
        Sum  : out std_logic_vector(SIZE - 1 downto 0) );
end entity adder_golden;

architecture golden of adder_golden is 
   signal x_us, y_us : unsigned(SIZE+1  downto 0);
   signal temp_sum_us : unsigned(SIZE+1 downto 0);
begin
   x_us <= unsigned('0' & x & '1');
   y_us <= unsigned('0' & y & Cin);
   temp_sum_us <= x_us + y_us;
   Cout <= temp_sum_us(SIZE+1);
   Sum <= std_logic_vector( temp_sum_us(SIZE downto 1) );
end architecture golden;
