library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity btc_32bit is
  generic( SIGNED_OPS : boolean := false ); --(Un)signed feature
  port( x : in std_logic_vector(31 downto 0); --First operand
	y : in std_logic_vector(31 downto 0);  --Second operand
        z_GSE : out std_logic_vector(2 downto 0)--Comparison results 
	); 
end entity btc_32bit;

--The configurable BTC-32 operates on unsigned operands if feature parameter SIGNED_OPS = false
--and operates on signed 2?s complement operands if feature parameter SIGNED_OPS = true. The
--BTC-32 comprises several BTC-8?s and CPC-2?s arranged in a binary tree. No other logic is allowed
--
--In an architecture named structure, model the configurable BTC-32 using entity instantiation
--statements and named association. Also, use simple concurrent signal assignment statements and
--the concatenation operator. Additionally, consider using constant objects and the open keyword
--when appropriate.

architecture structure of btc_32bit is 

signal c1,c2,c3,c4,c5,c6: std_logic_vector(2 downto 0); --intermediate signals connecting the comparaters 
constant un_signed : boolean := false;

begin

btc_8bit_1: entity work.btc_8bit(structure)
 generic map(SIGNED_OPS=> SIGNED_OPS)
 port map(x=>x(31 downto 24),y=>y(31 downto 24),z_GSE=>c1);


btc_8bit_2:  entity work.btc_8bit(structure)
generic map(SIGNED_OPS=> un_signed)
port map(x=>x(23 downto 16),y=>y(23 downto 16),z_GSE=>c2);
	

btc_8bit_3:  entity work.btc_8bit(structure)
generic map(SIGNED_OPS=> un_signed)
port map(x=>x(15 downto 8),y=>y(15 downto 8),z_GSE=>c3);


btc_8bit_4:  entity work.btc_8bit(structure)
generic map(SIGNED_OPS=> un_signed)
port map(x=>x(7 downto 0),y=>y(7 downto 0),z_GSE=>c4);
	
---------------------------------------------------------------------------		
cpc_2bit1: entity work.cpc_2bit(dataflow)
generic map(SIGNED_OPS=> un_signed)
port map(x=>c1(2) & c2(2),y=>c1(1) & c2(1),z_GSE=>c5);
	

cpc_2bit2: entity work.cpc_2bit(dataflow)
generic map(SIGNED_OPS=> un_signed)
port map(x=>c3(2) & c4(2),y=>c3(1) & c4(1),z_GSE=>c6);
	

cpc_2bit3: entity work.cpc_2bit(dataflow)
generic map(SIGNED_OPS=> un_signed)
port map (x=>c5(2) & c6(2),y=>c5(1) & c6(1),z_GSE=>z_GSE);

end architecture structure;