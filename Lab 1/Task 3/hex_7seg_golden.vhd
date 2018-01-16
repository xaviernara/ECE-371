library ieee;
use ieee.std_logic_1164.all;

entity hex_7seg_golden is
	port (  hex_val     : in std_logic_vector(3 downto 0);
	        en          : in std_logic;
		seg_lights  : out std_logic_vector(6 downto 0) );
end entity hex_7seg_golden;


architecture behavior of hex_7seg_golden is
   signal leds : std_logic_vector(6 downto 0);
   signal in_sig   : std_logic_vector(3 downto 0);
begin
  seg_lights <= leds(6 downto 0);
  in_sig <= hex_val;
   
	process(en, in_sig) is 
	begin
		if en = '1' then leds <= (others => '1');
		else 
			case in_sig is       --seg# 6543210
				when "0000" => leds <= "1000000";
				when "0001" => leds <= "1111001";
				when "0010" => leds <= "0100100";
				when "0011" => leds <= "0110000";
				when "0100" => leds <= "0011001";
				when "0101" => leds <= "0010010";
				when "0110" => leds <= "0000010";
				when "0111" => leds <= "1111000";
				when "1000" => leds <= "0000000";
				when "1001" => leds <= "0010000";
				when "1010" => leds <= "0001000";
				when "1011" => leds <= "0000011";
				when "1100" => leds <= "1000110";
				when "1101" => leds <= "0100001";
				when "1110" => leds <= "0000110";
				when "1111" => leds <= "0001110";
				when others => leds <= (others => '-');
			end case;
		end if;
   end process;
end architecture behavior;
