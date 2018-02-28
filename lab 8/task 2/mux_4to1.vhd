LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity mux_4to1 is 
	generic(SIZE : positive := 2);
	port( 	w0, w1, w2, w3  : in  std_logic_vector(SIZE-1 downto 0) ;
	     	f  : out  std_logic_vector(SIZE-1 downto 0); 
		s  : in std_logic_vector(1 downto 0));
		
end entity mux_4to1;

architecture behavior of mux_4to1 is 

   SIGNAL w_sig0: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL w_sig1: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL w_sig2: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL w_sig3: std_logic_vector(SIZE - 1 downto 0);

   SIGNAL w_AND0: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL w_AND1: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL w_AND2: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL w_AND3: std_logic_vector(SIZE - 1 downto 0);
--Internal Y_out signal
   SIGNAL y_sig0: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL y_sig1: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL y_sig2: std_logic_vector(SIZE - 1 downto 0);
   SIGNAL y_sig3: std_logic_vector(SIZE - 1 downto 0);
 
   SIGNAL    en: std_logic;
begin
	en <= '1';
	mux_array : for i in 0 to SIZE-1 generate
		
		dec_2to4 : entity work.dec_2to4(behavior)
		port map(w => s, y(0) => y_sig0(i),y(1) => y_sig1(i),y(2) => y_sig2(i),y(3) => y_sig3(i),en => en);
		f(i) <= w_AND0(i) or w_AND1(i) or w_AND2(i) or w_AND3(i);
		w_AND0(i) <= w_sig0(i) AND y_sig0(i);
		w_AND1(i) <= w_sig1(i) AND y_sig1(i);
		w_AND2(i) <= w_sig2(i) AND y_sig2(i);
		w_AND3(i) <= w_sig3(i) AND y_sig3(i);

		w_sig0(i) <= w0(i);
		w_sig1(i) <= w1(i);
		w_sig2(i) <= w2(i);
		w_sig3(i) <= w3(i);
		
	end generate;
end architecture behavior;
