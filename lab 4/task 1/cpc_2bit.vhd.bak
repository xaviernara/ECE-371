<<<<<<< HEAD
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpc_2bit is
  generic( SIGNED_OPS : boolean := false ); --(Un)signed feature
  port( x : in std_logic_vector(1 downto 0); --First operand
	y : in std_logic_vector(1 downto 0);  --Second operand
        z_GSE : out std_logic_vector(2 downto 0)--Comparison results 
	); 

end entity cpc_2bit;

--The CPC-2 operates on unsigned operands if feature parameter SIGNED_OPS = false and operates
--on signed two?s complement operands if feature parameter SIGNED_OPS = true. Your schematic
--should only use basic logic gates (NOT, AND, OR, NAND, etc.). No other logic is allowed. Try to
--minimize the number of gates in your design.


architecture dataflow of cpc_2bit is 

signal equal,greater,less :std_logic_vector(1 downto 0); --GREATER,LESS,EQUAL
--signal s_equal,s_greater,s_less :std_logic_vector(2 downto 0); --unsigned GREATER,LESS,EQUAL
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


--GREAT,LESS,EQUAL vectors to store the comparison of each bit.

equal(1) <= not (x(1) xor y(1));
equal(0) <= not (x(0) xor y(0));
greater(0) <= x(0) and (not y(0));
less(0) <= (not x(0)) and y(0);


Unsigned_bit_op :if (SIGNED_OPS = false) generate
		
--	equal(2) <= x(1) xnor y(1);
--	equal(1) <= x(0) xnor y(0);
	greater(1) <= x(1) and (not y(1));
	less(1) <= (not x(1)) and y(1);
	z_GSE(0) <= equal(1) and equal(0);  --unsigned equal
	
--      greater(2) <= x(1) and (not y(1));
--	greater(1) <= x(0) and (not y(0));
--	greater(0) <= equal(1) and greater(1);

	z_GSE(2)<= greater(1) or (greater(0) and  equal(1)); --unsigned greater

--	less(2) <= y(1) and (not x(1));
--	less(1) <= y(0) and (not x(0));
--	less(0) <= equal(1) and less(1);

	z_GSE(1)<= less(1) or(equal(1) and less(0)); --unsigned less
	
	end generate;
----------------------------------------------------------------------------------
	
	Signed_bit_op :if (SIGNED_OPS = TRUE) generate
--	s_equal(2) <= x(1) xnor y(1);
--	s_equal(1) <= x(0) xnor y(0);
	less(1)<= x(1) and (not y(1));
	greater(1)<= y(1) and (not x(1));
-- 	z_GSE(0) <= s_equal(1) and s_equal(0);  --signed equal

	z_GSE(0) <= equal(1) and equal(0);  --signed equal
	z_GSE(2)<= greater(1) or (greater(0) and  equal(1)); --signed greater
	z_GSE(1)<= less(1) or(less(0) and equal(1)); --signed less

--      s_greater(2) <= y(1) and (not x(1));
--	s_greater(1) <= y(0) and (not x(0));
--	s_greater(0) <= s_equal(1) and s_greater(1);
-- 	z_GSE(2)<= s_greater(2) or s_greater(0); --signed greater

--	s_less(2) <= x(1) and y(1);
--	s_less(1) <= x(0) and y(0);
--	s_less(0) <= s_equal(1) and s_less(1);
	--z_GSE(1)<= s_less(2) or s_less(0); --signed less

	end generate;


=======
<<<<<<< HEAD
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpc_2bit is
  generic( SIGNED_OPS : boolean := false ); --(Un)signed feature
  port( x : in std_logic_vector(1 downto 0); --First operand
	y : in std_logic_vector(1 downto 0);  --Second operand
        z_GSE : out std_logic_vector(2 downto 0)--Comparison results 
	); 

end entity cpc_2bit;

--The CPC-2 operates on unsigned operands if feature parameter SIGNED_OPS = false and operates
--on signed two?s complement operands if feature parameter SIGNED_OPS = true. Your schematic
--should only use basic logic gates (NOT, AND, OR, NAND, etc.). No other logic is allowed. Try to
--minimize the number of gates in your design.


architecture dataflow of cpc_2bit is 

signal equal,greater,less :std_logic_vector(1 downto 0); --GREATER,LESS,EQUAL
--signal s_equal,s_greater,s_less :std_logic_vector(2 downto 0); --unsigned GREATER,LESS,EQUAL
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


--GREAT,LESS,EQUAL vectors to store the comparison of each bit.

equal(1) <= not (x(1) xor y(1));
equal(0) <= not (x(0) xor y(0));
greater(0) <= x(0) and (not y(0));
less(0) <= (not x(0)) and y(0);


Unsigned_bit_op :if (SIGNED_OPS = false) generate
		
--	equal(2) <= x(1) xnor y(1);
--	equal(1) <= x(0) xnor y(0);
	greater(1) <= x(1) and (not y(1));
	less(1) <= (not x(1)) and y(1);
	z_GSE(0) <= equal(1) and equal(0);  --unsigned equal
	
--      greater(2) <= x(1) and (not y(1));
--	greater(1) <= x(0) and (not y(0));
--	greater(0) <= equal(1) and greater(1);

	z_GSE(2)<= greater(1) or (greater(0) and  equal(1)); --unsigned greater

--	less(2) <= y(1) and (not x(1));
--	less(1) <= y(0) and (not x(0));
--	less(0) <= equal(1) and less(1);

	z_GSE(1)<= less(1) or(equal(1) and less(0)); --unsigned less
	
	end generate;
----------------------------------------------------------------------------------
	
	Signed_bit_op :if (SIGNED_OPS = TRUE) generate
--	s_equal(2) <= x(1) xnor y(1);
--	s_equal(1) <= x(0) xnor y(0);
	less(1)<= x(1) and (not y(1));
	greater(1)<= y(1) and (not x(1));
-- 	z_GSE(0) <= s_equal(1) and s_equal(0);  --signed equal

	z_GSE(0) <= equal(1) and equal(0);  --signed equal
	z_GSE(2)<= greater(1) or (greater(0) and  equal(1)); --signed greater
	z_GSE(1)<= less(1) or(less(0) and equal(1)); --signed less

--      s_greater(2) <= y(1) and (not x(1));
--	s_greater(1) <= y(0) and (not x(0));
--	s_greater(0) <= s_equal(1) and s_greater(1);
-- 	z_GSE(2)<= s_greater(2) or s_greater(0); --signed greater

--	s_less(2) <= x(1) and y(1);
--	s_less(1) <= x(0) and y(0);
--	s_less(0) <= s_equal(1) and s_less(1);
	--z_GSE(1)<= s_less(2) or s_less(0); --signed less

	end generate;


=======
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpc_2bit is
  generic( SIGNED_OPS : boolean := false ); --(Un)signed feature
  port( x : in std_logic_vector(1 downto 0); --First operand
	y : in std_logic_vector(1 downto 0);  --Second operand
        z_GSE : out std_logic_vector(2 downto 0)--Comparison results 
	); 

end entity cpc_2bit;

--The CPC-2 operates on unsigned operands if feature parameter SIGNED_OPS = false and operates
--on signed two?s complement operands if feature parameter SIGNED_OPS = true. Your schematic
--should only use basic logic gates (NOT, AND, OR, NAND, etc.). No other logic is allowed. Try to
--minimize the number of gates in your design.


architecture dataflow of cpc_2bit is 

signal equal,greater,less :std_logic_vector(1 downto 0); --GREATER,LESS,EQUAL
--signal s_equal,s_greater,s_less :std_logic_vector(2 downto 0); --unsigned GREATER,LESS,EQUAL
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


--GREAT,LESS,EQUAL vectors to store the comparison of each bit.

equal(1) <= not (x(1) xor y(1));
equal(0) <= not (x(0) xor y(0));
greater(0) <= x(0) and (not y(0));
less(0) <= (not x(0)) and y(0);


Unsigned_bit_op :if (SIGNED_OPS = false) generate
		
--	equal(2) <= x(1) xnor y(1);
--	equal(1) <= x(0) xnor y(0);
	greater(1) <= x(1) and (not y(1));
	less(1) <= (not x(1)) and y(1);
	z_GSE(0) <= equal(1) and equal(0);  --unsigned equal
	
--      greater(2) <= x(1) and (not y(1));
--	greater(1) <= x(0) and (not y(0));
--	greater(0) <= equal(1) and greater(1);

	z_GSE(2)<= greater(1) or (greater(0) and  equal(1)); --unsigned greater

--	less(2) <= y(1) and (not x(1));
--	less(1) <= y(0) and (not x(0));
--	less(0) <= equal(1) and less(1);

	z_GSE(1)<= less(1) or(equal(1) and less(0)); --unsigned less
	
	end generate;
----------------------------------------------------------------------------------
	
	Signed_bit_op :if (SIGNED_OPS = TRUE) generate
--	s_equal(2) <= x(1) xnor y(1);
--	s_equal(1) <= x(0) xnor y(0);
	less(1)<= x(1) and (not y(1));
	greater(1)<= y(1) and (not x(1));
-- 	z_GSE(0) <= s_equal(1) and s_equal(0);  --signed equal

	z_GSE(0) <= equal(1) and equal(0);  --signed equal
	z_GSE(2)<= greater(1) or (greater(0) and  equal(1)); --signed greater
	z_GSE(1)<= less(1) or(less(0) and equal(1)); --signed less

--      s_greater(2) <= y(1) and (not x(1));
--	s_greater(1) <= y(0) and (not x(0));
--	s_greater(0) <= s_equal(1) and s_greater(1);
-- 	z_GSE(2)<= s_greater(2) or s_greater(0); --signed greater

--	s_less(2) <= x(1) and y(1);
--	s_less(1) <= x(0) and y(0);
--	s_less(0) <= s_equal(1) and s_less(1);
	--z_GSE(1)<= s_less(2) or s_less(0); --signed less

	end generate;


>>>>>>> b9c7629463188eb68b5e1250c466304018faba1b
>>>>>>> 69632eae6f22b9232cdd19c08328f81436b79a3d
end architecture dataflow;