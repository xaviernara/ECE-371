library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4to1 is 
   generic (SIZE : positive := 2); --Data bus widths
   port( w3  : in  std_logic_vector(SIZE-1  downto 0); --Data buses
	 w2  : in  std_logic_vector(SIZE-1  downto 0); --Data buses
	 w1  : in  std_logic_vector(SIZE-1  downto 0); --Data buses
	 w0  : in  std_logic_vector(SIZE-1  downto 0); --Data buses
	 S : in  std_logic_vector(1 downto 0); --Select Control
	 F  : out std_logic_vector(SIZE-1 downto 0) --Selected data
  );
end entity mux_4to1;

--In an architecture named mixed, model the 4-to-1 multiplexer according to the
--following modeling guidelines:

--Use entity instantiation statements to structurally model the minimum number of 2-to-4
--binary address decoders.

--Use a combination of for generate and simple concurrent signal assignment statements to
--model any additional combination logic.
--

architecture mixed of mux_4to1 is
 
 signal s_and_w :std_logic_vector(3 downto 0);
--signal s_and_w :std_logic_vector(SIZE-1 downto 0);

begin

decoder_2to4 : entity work.decode_2to4(BEHAVIOR)
   PORT MAP(w => s, en => '1', y=> s_and_w(3 downto 0));
	--PORT MAP(w => s, en => '1', y=> s_and_w(SIZE-1 downto 0));

combo_logic : for i in 0 to SIZE-1 generate
	--s_and_w<= (w3(i) and (s)) or (w2(i) and (s(1) and not s(0))) or (w1(i) and (not s(1) and s(0))) or (w0(i) and (not s));
	--F<= s_and_w;
	  --F<= (w3(i) and s_and_w(3)) or (w2(i) and s_and_w(2)) or (w1(i) and s_and_w(1)) or (w1(i) and s_and_w(0));
	 F(i) <= (w3(i) and s_and_w(i)) or (w2(i) and s_and_w(i)) or (w1(i) and s_and_w(i)) or (w0(i) and s_and_w(i));
	--F <= (w3(i) and s_and_w(i)) or (w2(SIZE-1-i) and s_and_w(i)) or (w1(SIZE-2-i) and s_and_w(i)) or (w1(SIZE-3-i) and s_and_w(i));
end generate combo_logic;

end architecture mixed;