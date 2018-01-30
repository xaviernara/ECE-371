library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_fsru_golden is
   generic( SIZE    : positive := 4; 
			CNT_VAL : positive := 3 );
   port( a               : in  std_logic_vector(SIZE-1 downto 0);
         en, shift, srin : in  std_logic;
         f               : out std_logic_vector(SIZE-1 downto 0) );
end entity right_fsru_golden;

architecture behavior of right_fsru_golden is
  signal sin : signed(0 downto 0);
begin
    
    sin(0) <= srin;
    fsru_proc : process( en, shift, a, sin) 
    begin
        if en = '0' then 
            f <= a;
        elsif shift = '0' then 
            f <= std_logic_vector(rotate_right(unsigned(a), CNT_VAL));
        else
            f(SIZE-CNT_VAL-1 downto 0) <= a(SIZE-1 downto CNT_VAL);
            f(SIZE-1 downto SIZE-CNT_VAL) <= std_logic_vector(resize(sin, CNT_VAL));
        end if;
    end process fsru_proc;
end architecture behavior;
