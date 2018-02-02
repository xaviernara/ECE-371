library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpc_2bit is
  generic( SIGNED_OPS : boolean := false ); --(Un)signed feature
  port( x : in std_logic_vector(1 downto 0); --First operand
	y : in std_logic_vector(1 downto 0);  --Second operand
        z_GSE : out std_logic_vector(2 downto 0); --Comparison results 
end entity cpc_2bit;

architecture dataflow of cpc_2bit is 

signal equal,greater,less :std_logic_vector(2 downto 0);



begin

--	equal(2) <= x(1) xnor y(1);
--	equal(1) <= x(0) xnor y(0);
--	z_GSE(0) <= equal(1) and equal(0);
--	
--        greater(2) <= x(1) and (not y(1));
--	greater(1) <= x(0) and (not y(0));
--	greater(0) <= equal(1) and greater(1);
--	z_GSE(2)<= greater(2) or greater(0);
--
--
--	less(2) <= y(1) and (not x(1));
--	less(1) <= y(0) and (not x(0));
--	less(0) <= equal(1) and less(1);
--	z_GSE(1)<= less(2) or less(0);


	 





 	Unsigned_bit_op :if (SIGNED_OPS = false) generate
		
	equal(2) <= x(1) xnor y(1);
	equal(1) <= x(0) xnor y(0);
	z_GSE(0) <= equal(1) and equal(0);
	
        greater(2) <= x(1) and (not y(1));
	greater(1) <= x(0) and (not y(0));
	greater(0) <= equal(1) and greater(1);
	z_GSE(2)<= greater(2) or greater(0);


	less(2) <= y(1) and (not x(1));
	less(1) <= y(0) and (not x(0));
	less(0) <= equal(1) and less(1);
	z_GSE(1)<= less(2) or less(0);

	
	Signed_bit_op :if (SIGNED_OPS = TRUE) generate
		z(2)<= not(x xor y);
		z(1)<= x and y;
		z(0)<= y and (not x);  


