library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity log_bsru_golden is
   generic( SHMT : positive := 2 );
   port( a                : in  std_logic_vector(2**SHMT-1 downto 0);
         cnt              : in  std_logic_vector(SHMT-1 downto 0);
         arith, shift, right : in  std_logic;
         f                : out std_logic_vector(2**SHMT-1 downto 0) );
end entity log_bsru_golden;

architecture behavior of log_bsru_golden is
begin
    log_bsru_proc : process(arith, shift, right, a) 
    begin
        if shift = '0' then 
            if right = '0' then 
                f <= std_logic_vector(rotate_left(unsigned(a), to_integer(unsigned(cnt))));
            else
                f <= std_logic_vector(rotate_right(unsigned(a), to_integer(unsigned(cnt))));
            end if;
        else
            if right = '0' then 
                f <= std_logic_vector(shift_left(unsigned(a), to_integer(unsigned(cnt))));
            else
                if arith = '1' then
                    f <= std_logic_vector(shift_right(signed(a), to_integer(unsigned(cnt))));
                else
                    f <= std_logic_vector(shift_right(unsigned(a), to_integer(unsigned(cnt))));
                end if;
            end if;
        end if;
    end process log_bsru_proc;
end architecture behavior;
