<<<<<<< HEAD
library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is 
   generic (SIZE : positive := 4); --Data bus widths
   port( w7  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w6  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w5  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w4  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w3  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w2  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w1  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w0  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 S : in  std_logic_vector(2 downto 0); --Select Control
	 F  : out std_logic_vector(SIZE-1 downto 0) --Selected data
  );
end entity mux_8to1 ;

--In an architecture named structure, use entity instantiation statements to structurally model
--each 4-to-1 multiplexer employed to realize the 8-to-1 multiplexer

architecture structure of mux_8to1 is
--signal z :std_logic_vector(3 downto 0); --the intermediate signal that connects the mux's
--signal z :std_logic_vector(2 downto 0); --the intermediate signal that connects the mux's
signal z1 :std_logic_vector(SIZE-1 downto 0);
signal z2 :std_logic_vector(SIZE-1 downto 0);
--signal z1 :std_logic_vector(1 downto 0);
--signal z2 :std_logic_vector(1 downto 0);
--SIGNAL zero : std_logic_vector (SIZE-1 DOWNTO 0) := (OTHERS=> '0' );
constant zero : std_logic_vector(SIZE-1 downto 0) := ('0', others => '0');

begin

   mux1_4to1 : entity work.mux_4to1(mixed)
   GENERIC MAP (SIZE => SIZE) 
	--PORT MAP(w3 => w7, w2 => w6, w1 => w5, w0 => w4, S<= S(1 downto 0), F <= z( 3 downto 2));
	--PORT MAP(w7, w6, w5, w4, S(1 downto 0), z( 3 downto 2));
	PORT MAP(w3 => w7, w2 => w6, w1 => w5, w0 => w4, S=> S(1 downto 0), F => z1( SIZE-1 downto 0));

   mux2_4to1 : entity work.mux_4to1(mixed)
   GENERIC MAP (SIZE => SIZE) 
	--PORT MAP(w3 => w3, w2 => w2, w1 => w1, w0 => w0, S<= S(1 downto 0), F <= z( 1 downto 0));
	PORT MAP(w3, w2, w1, w0, S(1 downto 0), z2( SIZE-1 downto 0));

   mux3_4to1 : entity work.mux_4to1(mixed)
   GENERIC MAP (SIZE => SIZE) 
	--PORT MAP(w3 =>z(3), w2 => z(2), w1 => z(1), w0 => z(0), S<= S(2 downto 1), F <= F);
	--PORT MAP(z(3), z(2), z(1), z(0), S(2 downto 1), F);
	--PORT MAP(w3 =>z(1), w2 => z(1), w1 => z(0), w0 => z(0), S<= S(2 downto 1), F <= F);
	--PORT MAP(w3 =>z(1), w2 => z(1), w1 => z(0), w0 => z(0), S(1)<= S(2), S(0)<= '0', F <= F);
	PORT MAP(w3 =>zero, w2 => zero, w1 => z2, w0 => z1, S(0)=> S(2), S(1)=> '0', F => F);
	--PORT MAP(z(1), z(1), z(0), z(0), S(2 downto 1), F);
end architecture structure;
=======
library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is 
   generic (SIZE : positive := 4); --Data bus widths
   port( w7  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w6  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w5  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w4  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w3  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w2  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w1  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 w0  : in  std_logic_vector(SIZE-1 downto 0); --Data buses
	 S : in  std_logic_vector(2 downto 0); --Select Control
	 F  : out std_logic_vector(SIZE-1 downto 0) --Selected data
  );
end entity mux_8to1 ;

--In an architecture named structure, use entity instantiation statements to structurally model
--each 4-to-1 multiplexer employed to realize the 8-to-1 multiplexer

architecture structure of mux_8to1 is
--signal z :std_logic_vector(3 downto 0); --the intermediate signal that connects the mux's
--signal z :std_logic_vector(2 downto 0); --the intermediate signal that connects the mux's
signal z1 :std_logic_vector(SIZE-1 downto 0);
signal z2 :std_logic_vector(SIZE-1 downto 0);
--signal z1 :std_logic_vector(1 downto 0);
--signal z2 :std_logic_vector(1 downto 0);
--SIGNAL zero : std_logic_vector (SIZE-1 DOWNTO 0) := (OTHERS=> '0' );
constant zero : std_logic_vector(SIZE-1 downto 0) := ('0', others => '0');

begin

   mux1_4to1 : entity work.mux_4to1(mixed)
   GENERIC MAP (SIZE => SIZE) 
	--PORT MAP(w3 => w7, w2 => w6, w1 => w5, w0 => w4, S<= S(1 downto 0), F <= z( 3 downto 2));
	--PORT MAP(w7, w6, w5, w4, S(1 downto 0), z( 3 downto 2));
	PORT MAP(w3 => w7, w2 => w6, w1 => w5, w0 => w4, S=> S(1 downto 0), F => z1( SIZE-1 downto 0));

   mux2_4to1 : entity work.mux_4to1(mixed)
   GENERIC MAP (SIZE => SIZE) 
	--PORT MAP(w3 => w3, w2 => w2, w1 => w1, w0 => w0, S<= S(1 downto 0), F <= z( 1 downto 0));
	PORT MAP(w3, w2, w1, w0, S(1 downto 0), z2( SIZE-1 downto 0));

   mux3_4to1 : entity work.mux_4to1(mixed)
   GENERIC MAP (SIZE => SIZE) 
	--PORT MAP(w3 =>z(3), w2 => z(2), w1 => z(1), w0 => z(0), S<= S(2 downto 1), F <= F);
	--PORT MAP(z(3), z(2), z(1), z(0), S(2 downto 1), F);
	--PORT MAP(w3 =>z(1), w2 => z(1), w1 => z(0), w0 => z(0), S<= S(2 downto 1), F <= F);
	--PORT MAP(w3 =>z(1), w2 => z(1), w1 => z(0), w0 => z(0), S(1)<= S(2), S(0)<= '0', F <= F);
	PORT MAP(w3 =>zero, w2 => zero, w1 => z2, w0 => z1, S=> S(2) & '0', F => F);
	--PORT MAP(z(1), z(1), z(0), z(0), S(2 downto 1), F);
end architecture structure;
>>>>>>> 5e6ea64a5fd18b0da54a6bdcdd8534fa87e3ee05
