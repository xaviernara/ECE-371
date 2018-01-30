library ieee;
use ieee.std_logic_1164.all;

entity bru is
generic (SIZE : positive := 4);--Input bus width
port (	A : in std_logic_vector(SIZE-1 downto 0); --Bits to selective reverse
     pass : in std_logic; --Bit-reverse control
	Y : out std_logic_vector(SIZE-1 downto 0));--Selectively reversed bits
end bru;
--The BRU comprises several multiplexersand ?wire arrangement? logic
--No other logic is allowed
--In an architecturenamed behavior, model the generic BRU using 
--concurrent for...generate and concurrent conditional signal assignmentstatements (CCSA).  

architecture behavior of bru is

begin
--for generate to reverse bits
reversing_bits : for index in SIZE-1 downto 0 generate
	Y(index) <= A(SIZE-1-index) when pass = '0' else
		A(index);
end generate reversing_bits;

end architecture behavior;
