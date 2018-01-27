library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_golden is
  generic(SIZE : positive := 4);
  port( en : in  std_logic;
        w  : in  std_logic_vector(SIZE-1 downto 0);
        y  : out std_logic_vector(2**SIZE-1 downto 0) );
end entity decoder_golden;

architecture behavior of decoder_golden is
   signal w_us : unsigned(SIZE-1 downto 0);
   signal y_us : unsigned(2**SIZE-1 downto 0);
begin
  w_us <= unsigned(w);
  y <= std_logic_vector(y_us);
  dec : process(en, w_us) is
     variable dec_out : unsigned(2**SIZE-1 downto 0);
  begin
    dec_out := (others => '0');
    if en = '1' then
       for i in 0 to 2**SIZE-1 loop
          if w_us = to_unsigned(i, SIZE) then 
             dec_out(i) := '1';
             exit;
          end if;
        end loop;
    end if;
    y_us <= dec_out;
  end process dec;
end architecture behavior;