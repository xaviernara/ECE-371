library ieee;
use ieee.std_logic_1164.all;

entity cla_2bit is
	port( x, y   : in  std_logic_vector(1 downto 0);   
	      cin    : in  std_logic;   
		  sum    : out std_logic_vector(1 downto 0);
          cout   : out std_logic;
          GG, GA : out std_logic ); 
end entity cla_2bit;

architecture mixed of cla_2bit is
   signal g, a, p : std_logic_vector(1 downto 0);
   signal carries : std_logic_vector(2 downto 0);
begin
	--generate bitwise (g, a ,p)'s
	g <= x and y;
	a <= x or y;
	p <= x xor y;

    --assign carries
	carries(0) <= cin;
	cout <= carries(2);

	--instantiate a 2-bit carry look-ahead generator (CLG)
	cla : entity work.clg_2bit(dataflow)
	port map( g => g, a => a, cin => cin, 
			  carries => carries(2 downto 1), 
			  GG => GG, GA => GA);

	--generate bitwise sums
    sum <= p xor carries(1 downto 0);

end architecture mixed;
