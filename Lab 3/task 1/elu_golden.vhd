library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elu_golden is
	generic( ISIZE : positive := 5;
		     OSIZE : positive := 10 );
	port( A        : in  std_logic_vector(ISIZE-1 downto 0);
		  arith    : in  std_logic;
		  Y        : out std_logic_vector(OSIZE-1 downto 0) );
end entity elu_golden;

architecture behavior of elu_golden is
   signal a_us : unsigned(ISIZE-1 downto 0);
begin	
	with arith select
	   Y <= std_logic_vector( resize( signed(A), OSIZE ) )  when '1', 
	        std_logic_vector( resize( unsigned(A), OSIZE ) ) when others;
end architecture behavior;
