library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compare_golden is
  generic( SIZE : positive := 3 );
  port( x, y : in std_logic_vector(SIZE - 1 downto 0);
        cinE, cinG, cinS : std_logic;
        arith  : in std_logic;
        z_GSE : out std_logic_vector(2 downto 0) );
end entity compare_golden;

architecture golden of compare_golden is 
   signal x_us, y_us : unsigned(SIZE-1 downto 0);
   signal x_s, y_s   : signed(SIZE-1 downto 0);
   signal eq_us, lt_us, gt_us : std_logic;
   signal eq_s, lt_s, gt_s : std_logic;
   alias zE : std_logic is z_GSE(0);
   alias zS : std_logic is z_GSE(1);
   alias zG : std_logic is z_GSE(2);
begin
   x_us <= unsigned(x);
   y_us <= unsigned(y);
   x_s <= signed(x);
   y_s <= signed(y);
   
   eq_s <= '1'  when ((x_s = y_s) and cinE = '1') else '0';
   lt_s <= '1'  when ((x_s < y_s) or ((cinS = '1') and (x_s = y_s))) else '0';
   gt_s <= '1'  when ((x_s > y_s) or ((cinG = '1') and (x_s = y_s))) else '0';

   eq_us <= '1' when ((x_us = y_us) and cinE = '1') else '0';
   lt_us <= '1' when ((x_us < y_us) or ((cinS = '1') and (x_us = y_us))) else '0';
   gt_us <= '1' when ((x_us > y_us) or ((cinG = '1') and (x_us = y_us))) else '0';
   
   zE <= eq_s when arith = '1' else eq_us;
   zS <= lt_s when arith = '1' else lt_us;
   zG <= gt_s when arith = '1' else gt_us;
end architecture golden;
