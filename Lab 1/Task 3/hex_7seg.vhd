library ieee;
use ieee.std_logic_1164.all;

entity  hex_7seg is 
  port(
	en  : in std_logic; --Active high output enable
	hex_val : in std_logic_vector(3 downto 0); --Hex value to be displayed
   seg_lights : out std_logic_vector(6 downto 0)--Seven LED segment drivers
   );
end entity;

-- A hexadecimal-to-7-segment display decoder/driver is a decoder that takes a 4-bit unsigned binary
-- number and decodes it to a 7-bit binary signal used to illuminate the appropriate LED segments of a 7-segment display unit. 
-- The 7-segment display unit?s indexing scheme is provided in Figure 2. Each LED segment is identified by
-- a natural number called an index. The index ranges from 0 (the top LED segment) to 6 (the middle LED
-- segment). The goal is to display the sixteen combinations of 4-bit unsigned binary numbers in
-- hexadecimal format on the 7-segment display unit. The sixteen hexadecimal LED segment patterns are
-- also shown in Figure 2.
-- The 7-segment decoder/driver combinational network contains an enable signal. To disable (enable) the
-- operation of the 7-segment display unit thereby turning off (on) all seven LED segments, drive the enable
-- signal with a low (high) logic level. To illuminate (darken) the j
-- th LED segment on the 7-segment display
-- unit, the 7-segment decoder/driver combinational network drives the j
-- the LED segment with a logic low
-- (high) level.

-- In an architecture named behavior, utilize a single concurrent selected signal assignment (CSSA)
-- statement and the concatenation (&) operator to model the hex-to-7-segment decoder/driver. 

architecture behavior of hex_7seg is
  signal hex_en :std_logic_vector(4 downto 0);
  --signal q : std_logic_vector(2 downto 0); 
begin

hex_en <= en & hex_val;
--hex_en_sel <= enable & hex_val
--with hex_en select
--with en select
--    seg_lights<=  "0000001" when hex_val <= "0000",  -- '0'
--    seg_lights<=  "1001111" when hex_val <= "0001",  -- '1'
--    seg_lights<=  "0010010" when hex_val <= "0010",  -- '2'
--    seg_lights<=  "0000110" when hex_val <= "0011",  -- '3'
--    seg_lights<=  "1001100" when hex_val <= "0100",  -- '4'
--    seg_lights<=  "0100100" when hex_val <= "0101",  -- '5'
--    seg_lights<=  "0100000" when hex_val <= "0110",  -- '6'
--    seg_lights<=  "0001111" when hex_val <= "0111",  -- '7'  
--    seg_lights<=  "0000000" when hex_val <= "1000",  -- '8'
--    seg_lights<=  "0000100" when hex_val <= "1001",  -- '9'
--    seg_lights<=  "0001000" when hex_val <= "1010",  -- 'A'
--    seg_lights<=  "1100000" when hex_val <= "1011",  -- 'b'
--    seg_lights<=  "0110001" when hex_val <= "1100",  -- 'C'
--    seg_lights<=  "1000010" when hex_val <= "1101",  -- 'd'
--    seg_lights<=  "0110000" when hex_val <= "1110",  -- 'E'
--    seg_lights<=  "0111000" when hex_val <= others;  -- 'F'

--   seg_lights<=  "0000001" when "0000",  -- '0'
--   seg_lights<=  "1001111" when "0001",  -- '1'
--   seg_lights<=  "0010010" when "0010",  -- '2'
--   seg_lights<=  "0000110" when "0011",  -- '3'
--   seg_lights<=  "1001100" when "0100",  -- '4'
--   seg_lights<=  "0100100" when "0101",  -- '5'
--   seg_lights<=  "0100000" when "0110",  -- '6'
--   seg_lights<=  "0001111" when "0111",  -- '7'  
--   seg_lights<=  "0000000" when "1000",  -- '8'
--   seg_lights<=  "0000100" when "1001",  -- '9'
--   seg_lights<=  "0001000" when "1010",  -- 'A'
--   seg_lights<=  "1100000" when "1011",  -- 'b'
--   seg_lights<=  "0110001" when "1100",  -- 'C'
--   seg_lights<=  "1000010" when "1101",  -- 'd'
--   seg_lights<=  "0110000" when "1110",  -- 'E'
--   --seg_lights<=  "0111000" when "1111",  -- 'F'
--   seg_lights<=  "0111000" when others;  -- 'F'

with hex_en select
--   seg_lights<=  "0000001" when "00000",  -- '0'
--   		 "1001111" when "00001",  -- '1'
--   		 "0010010" when "00010",  -- '2'
--            	 "0000110" when "00011",  -- '3'
--     		 "1001100" when "00100",  -- '4'
--     		 "0100100" when "00101",  -- '5'
--     		 "0100000" when "00110",  -- '6'
--     		 "0001111" when "00111",  -- '7'  
--     		 "0000000" when "01000",  -- '8'
--     	         "0000100" when "01001",  -- '9'
--    		 "0001000" when "01010",  -- 'A'
--     		 "1100000" when "01011",  -- 'b'
--     		 "0110001" when "01100",  -- 'C'
--     		 "1000010" when "01101",  -- 'd'
--     		 "0110000" when "01110",  -- 'E'
--    		 "0111000" when others;  -- 'F' 
----       
seg_lights<= "1000000" when "00000",  -- '0'
				 "1111001" when "00001",  -- '1'
   		    "0100100" when "00010",  -- '2'
             "0110000" when "00011",  -- '3'
     		    "0011001" when "00100",  -- '4'
     		    "0010010" when "00101",  -- '5'
     		    "0000010" when "00110",  -- '6'
     		    "1111000" when "00111",  -- '7'  
     		    "0000000" when "01000",  -- '8'
     	       "0010000" when "01001",  -- '9'
    		    "0001000" when "01010",  -- 'A'
     		    "0000011" when "01011",  -- 'b'
     		    "1000110" when "01100",  -- 'C'
     		    "0100001" when "01101",  -- 'd'
     		    "0000110" when "01110",  -- 'E'
    		    "0001110" when "01111",  -- 'F' 
             "1111111" when others; --all lights off
--      
   --process(hex_val, enable)
   -- process(hex_en) is BEGIN
--     case hex_val is
--         when "0000"=> hex_val <="0000001";  -- '0'
--         when "0001"=> hex_val <="1001111";  -- '1'
--         when "0010"=> hex_val <="0010010";  -- '2'
--         when "0011"=> hex_val <="0000110";  -- '3'
--         when "0100"=> hex_val <="1001100";  -- '4' 
--         when "0101"=> hex_val <="0100100";  -- '5'
--         when "0110"=> hex_val <="0100000";  -- '6'
--         when "0111"=> hex_val <="0001111";  -- '7'
--         when "1000"=> hex_val <="0000000";  -- '8'
--         when "1001"=> hex_val <="0000100";  -- '9'
--         when "1010"=> hex_val <="0001000";  -- 'A'
--         when "1011"=> hex_val <="1100000";  -- 'b'
--         when "1100"=> hex_val <="0110001";  -- 'C'
--         when "1101"=> hex_val <="1000010";  -- 'd'
--         when "1110"=> hex_val <="0110000";  -- 'E'
--         when "1111"=> hex_val <="0111000";  -- 'F'
--         when others =>  NULL;
--     end case;
--end process; 
end architecture behavior;
