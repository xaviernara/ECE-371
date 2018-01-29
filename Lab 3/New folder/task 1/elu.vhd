library ieee;
use ieee.std_logic_1164.all;
entity elu is

generic (ISIZE		: positive := 5; --Input bus width
	 OSIZE 		: positive := 10); --Output bus width
port 	(A   		: in std_logic_vector(ISIZE-1 downto 0);--Operand to extend
	 arith	     : in std_logic; --Unsigned/signed control
	 Y		: out std_logic_vector(OSIZE-1 downto 0)); --Extended operand
end elu;

--In an architecture named dataflow, consider modeling the  generic  
--ELU using generate statements(for, if/else, and/or case),vector aggregate assignment(s), and logical operator(s).  

architecture dataflow of elu is
--zeroes signal to increase size of vector
signal z1: std_logic;

begin

z1 <= arith and A(ISIZE-1);

Y(ISIZE-1 downto 0) <= A;
Y(OSIZE-1 downto ISIZE) <= (others => z1);
end dataflow;

