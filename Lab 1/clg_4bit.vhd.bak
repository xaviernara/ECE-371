library ieee;
use ieee.std_logic_1164.all;

entity clg_4bit is 
    port(
	c0 : in std_logic; --Initial input carry
	g  : in std_logic_vector(3 downto 0); --Bit-level carry generate
	a  : in std_logic_vector(3 downto 0); --Bit-level carry alive
	c : out  std_logic_vector(3 downto 0); --Bit-level output carries
	GG : OUT std_logic; --group generate
	GA : OUT std_logic --group ALIVE
   );
end entity;

--In an architecture named dataflow, utilize several simple concurrent signal assignment
--statements in addition to intermediate signals to model the 4-bit CLG using several Boolean logic expressions.
architecture dataflow of clg_4bit is
	
  signal and_or : std_logic_vector(2 downto 0);
  signal or_or : std_logic_vector(2 downto 0);
  signal or_and : std_logic_vector(2 downto 0);
  signal and_or2 : std_logic_vector(1 downto 0);
  signal and_or3 : std_logic;
  SIGNAL and_and : std_logic_vector(2 downto 0);
  signal z_and : std_logic_vector(3 downto 0);  
  signal z_or : std_logic_vector(2 downto 0); 

   
begin
   	and_or(2) <= (g(2) and a(3));
	and_or(1) <= (g(1) and a(3) and a(2));
	and_or(0) <= (g(0) and a(3) and a(2) and a(1));
	z_or(2) <= g(3) or and_or;
------------------------------------------------------
        and_or2(1) <= (g(1) and a(2));
	and_or2(0) <= (a(1) and a(2) and g(0));
	z_or(1) <= g(2) or and_or2;
------------------------------------------------------        
	and_or3 <= a(1) and g(0);
	--and_or3(0) <= a(1) and a(0); 
	z_or(0) <= g(1) or and_or3;
------------------------------------------------------ 	
	and_and(2) <= (a(0) and a(3) and a(2) and a(1));
	z_and(3)<= GA and (and_and(2) and c0);

------------------------------------------------------	 
	and_and(1) <= (a(0) and a(2) and a(1));
	z_and(2)<= (and_and(1) and c0);

------------------------------------------------------	 
	and_and(0) <= a(1) and a(0);
      	z_and(1)<= and_and(0) and c0;
 	z_and(0)<= (a(0) and c0);
------------------------------------------------------	 	
	c(3)<= GG or (z_or(2) and z_and(3)); 
	c(2)<= (z_or(2) and z_and(2));
	c(1)<= (z_or(1) and z_and(1));
	c(0)<= (z_or(0) and z_and(0));


	
	--and_or(0) <= (g(3) or and_or(3) or and_or(2) or and_or() or and_or(3);
	
--or (g(1) and a(3) and a(2)) or (g(0) and a(3) and a(2) and a(1)) or g(3)   

end architecture dataflow;


