library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity cla_32bit_tb is
end entity cla_32bit_tb;

architecture behavior of cla_32bit_tb is   
   constant SIZE_ONE : positive := 32;
   constant DELAY_TIME : delay_length := 1 ps;
   constant NUM_TEST_CASES : positive := 300000;
   constant MAX_NAT16 : natural := 2**(SIZE_ONE/2)-1;
   
   signal sum_dut, sum_gm : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal cout_dut, cout_gm : std_logic_vector(0 downto 0) := (others => '0');
   signal cin_stim : std_logic_vector(0 downto 0) := (others => '0');
   signal x_stim : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal y_stim : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal GG_GA_dut, GG_GA_gm : std_logic_vector(1 downto 0) := (others => '0');
   signal g_stim, a_stim : std_logic_vector(SIZE_ONE-1 downto 0);
   alias x_stim_hi : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias x_stim_lo : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim((SIZE_ONE/2)-1 downto 0);    
   alias y_stim_hi : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias y_stim_lo : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim((SIZE_ONE/2)-1 downto 0);    

   procedure rand_int( variable seed1, seed2 : inout positive; 
	                                min, max : in integer; 
								      result : out natural ) is
      variable rand      : real;
	  variable val_range : real;
   begin
      assert (max >= min) report "Rand_int: Range Error" 
	       severity failure;    
      uniform(seed1, seed2, rand);
      val_range := real(Max - Min + 1);
	  result := abs(integer( trunc(rand * val_range )) + min);
   end procedure;
 
begin
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit CLA
  ------------------------------------------------------------------------------------------
  gm1 : entity work.adder_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim),
              y => std_logic_vector(y_stim),
              cin => cin_stim(0),
              sum => sum_gm,
              cout => cout_gm(0) );

  g_stim <= std_logic_vector(x_stim and y_stim);
  a_stim <= std_logic_vector(x_stim or y_stim);
  
  gm1_clg : entity work.clg_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  c0 => Cin_stim(0),
              g => g_stim, p => a_stim,
              c => open,
              GG => GG_GA_gm(1),
              GP => GG_GA_gm(0) );
  
  dut1 : entity work.cla_32bit(structure)
  port map (  x => std_logic_vector(x_stim),
              y => std_logic_vector(y_stim),
              cin => cin_stim(0),
              sum => sum_dut,
              cout => cout_dut(0), 
		      GG => GG_GA_dut(1),
              GA => GG_GA_dut(0) );

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE CLA
  ------------------------------------------------------------------------------------------
  stim_gen : process is 
	   variable seed1, seed2 : positive := 68303356; --any number will do. Different seed value changes the sequence.
 	   variable x_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable x_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable cin_int      : natural range 0 to 1;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
         wait for DELAY_TIME;
		 assert (sum_dut = sum_gm)
            report "@TB: Output missmatch:" & LF &
                   "(cin_stim) = 0x" & to_hstring(cin_stim) & LF &
                   "(x_stim) = 0x" & to_hstring(x_stim) & LF &
                   "(y_stim) = 0x" & to_hstring(y_stim) & LF &
                   "(sum_dut) = 0x" & to_hstring(sum_dut) & LF &
                   "(sum_gm) = 0x" & to_hstring(sum_gm)
            severity note;
          assert (cout_dut = cout_gm)
            report "@TB: Output missmatch:" & LF &
                   "(cin_stim) = 0x" & to_string(cin_stim) & LF &
                   "(x_stim) = 0x" & to_hstring(x_stim) & LF &
                   "(y_stim) = 0x" & to_hstring(y_stim) & LF &
                   "(cout_dut) = 0x" & to_hstring(cout_dut) & LF &
                   "(cout_gm) = 0x" & to_hstring(cout_gm)
            severity note;
		 assert (GG_GA_dut = GG_GA_gm)
            report "@TB: Output missmatch:" & LF &
                   "(cin_stim) = 0x" & to_hstring(cin_stim) & LF &
                   "(x_stim) = 0x" & to_hstring(x_stim) & LF &
                   "(y_stim) = 0x" & to_hstring(y_stim) & LF &
                   "(GG_GA_dut) = 0x" & to_hstring(GG_GA_dut) & LF &
                   "(GG_GA_gm) = 0x" & to_hstring(GG_GA_gm)
            severity note;
         wait for DELAY_TIME;
	     -----------------------------------------------------------
	     --generate random inputs for x_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int_hi); 
	     x_stim_hi <= std_logic_vector(to_unsigned( x_int_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int_lo); 
	     x_stim_lo <= std_logic_vector(to_unsigned( x_int_lo, (SIZE_ONE/2)));
	     -----------------------------------------------------------
	     --generate random inputs for y_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int_hi); 
	     y_stim_hi <= std_logic_vector(to_unsigned( y_int_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int_lo); 
	     y_stim_lo <= std_logic_vector(to_unsigned( y_int_lo, (SIZE_ONE/2)));
	     -----------------------------------------------------------
	     --generate random inputs for cin_stim
	     -----------------------------------------------------------     	     
	      rand_int(seed1, seed2,  0, 1, cin_int); 
 	     cin_stim <= std_logic_vector(to_unsigned( cin_int, 1));
 	     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit CLA passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process stim_gen;
end architecture behavior;
