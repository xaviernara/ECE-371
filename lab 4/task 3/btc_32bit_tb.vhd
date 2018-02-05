library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity btc_32bit_tb is
end entity btc_32bit_tb;

architecture behavior of btc_32bit_tb is   
   constant DELAY_TIME : delay_length := 1 ps;
   constant NUM_TEST_CASES : positive := 300000;
   constant SIZE_ONE : positive := 32;

   constant MAX_NAT16 : natural := 2**(SIZE_ONE/2)-1;

   constant SIGNED_ONE_BOOL : boolean := true;
   constant SIGNED_ONE_STL : std_logic := '1';
   
   constant SIGNED_TWO_BOOL : boolean := false;
   constant SIGNED_TWO_STL : std_logic := '0';
   
   signal x_stim1 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal y_stim1 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   alias x_stim_hi1 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim1(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias x_stim_lo1 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim1((SIZE_ONE/2)-1 downto 0);    
   alias y_stim_hi1 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim1(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias y_stim_lo1 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim1((SIZE_ONE/2)-1 downto 0);    

   signal x_stim2 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal y_stim2 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   alias x_stim_hi2 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim2(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias x_stim_lo2 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim2((SIZE_ONE/2)-1 downto 0);    
   alias y_stim_hi2 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim2(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias y_stim_lo2 : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim2((SIZE_ONE/2)-1 downto 0);    


   signal z_GSE_dut1, z_GSE_dut2 : std_logic_vector(2 downto 0) := (others => '0');
   signal z_GSE_gm1, z_GSE_gm2 : std_logic_vector(2 downto 0) := (others => '0');


   procedure rand_int( variable seed1, seed2 : inout positive; 
	 	                            min, max : in integer; 
				                      result : out natural) is
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
  --  for SIZE_ONE-bit BTC with SIGNED_OPS = SIGNED_ONE_BOOL
  ------------------------------------------------------------------------------------------
  gm1 : entity work.compare_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              arith => SIGNED_ONE_STL,
              cinE => '1', 
              cinG => '0', 
              cinS => '0',
			  z_GSE => Z_GSE_gm1 );
  
  dut1 : entity work.btc_32bit(structure)
  generic map( SIGNED_OPS => SIGNED_ONE_BOOL )
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
			  z_GSE => Z_GSE_dut1 );

  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit BTC with SIGNED_OPS = SIGNED_TWO_BOOL
  ------------------------------------------------------------------------------------------
  gm2 : entity work.compare_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim2),
              y => std_logic_vector(y_stim2),
              arith => SIGNED_TWO_STL,
              cinE => '1', 
              cinG => '0', 
              cinS => '0',
 			  z_GSE => Z_GSE_gm2 );
  
  dut2 : entity work.btc_32bit(structure)
  generic map( SIGNED_OPS => SIGNED_TWO_BOOL )
  port map (  x => std_logic_vector(x_stim2),
              y => std_logic_vector(y_stim2),
 			  z_GSE => Z_GSE_dut2 );
                
  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is 
  	   variable seed1, seed2 : positive := 39537874; --any number will do. Different seed value changes the sequence.
 	   variable x_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable x_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
         wait for DELAY_TIME;
		 assert (z_GSE_gm1 = z_GSE_dut1)
            report "@TB: Output missmatch:" & LF &
                   "(x_stim1) = 0x" & to_hstring(x_stim1) & LF &
                   "(y_stim1) = 0x" & to_hstring(y_stim1) & LF &
				   "(z_GSE_dut1) 0x" & to_hstring(z_GSE_dut1) & LF &
                   "(z_GSE_gm1) = 0x" & to_hstring(z_GSE_gm1)
            severity failure;
	     -----------------------------------------------------------
	     --generate random inputs for x_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int_hi); 
	     x_stim_hi1 <= std_logic_vector(to_unsigned( x_int_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int_lo); 
	     x_stim_lo1 <= std_logic_vector(to_unsigned( x_int_lo, (SIZE_ONE/2)));
	     -----------------------------------------------------------
	     --generate random inputs for y_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int_hi); 
	     y_stim_hi1 <= std_logic_vector(to_unsigned( y_int_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int_lo); 
	     y_stim_lo1 <= std_logic_vector(to_unsigned( y_int_lo, (SIZE_ONE/2)));
     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit BTC with SIGNED_OPS = " & to_string(SIGNED_ONE_BOOL) & " passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process stim_gen1;

    ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  stim_gen2 : process is 
  	   variable seed1, seed2 : positive := 47873593;  --any number will do. Different seed value changes the sequence.
 	   variable x_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable x_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
         wait for DELAY_TIME;
		 assert (z_GSE_gm2 = z_GSE_dut2)
            report "@TB: Output missmatch:" & LF &
                   "(x_stim2) = 0x" & to_hstring(x_stim2) & LF &
                   "(y_stim2) = 0x" & to_hstring(y_stim2) & LF &
				   "(z_GSE_dut2) 0x" & to_hstring(z_GSE_dut2) & LF &
                   "(z_GSE_gm2) = 0x" & to_hstring(z_GSE_gm2)
            severity failure;
	     -----------------------------------------------------------
	     --generate random inputs for x_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int_hi); 
	     x_stim_hi2 <= std_logic_vector(to_unsigned( x_int_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int_lo); 
	     x_stim_lo2 <= std_logic_vector(to_unsigned( x_int_lo, (SIZE_ONE/2)));
	     -----------------------------------------------------------
	     --generate random inputs for y_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int_hi); 
	     y_stim_hi2 <= std_logic_vector(to_unsigned( y_int_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int_lo); 
	     y_stim_lo2 <= std_logic_vector(to_unsigned( y_int_lo, (SIZE_ONE/2)));
     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit BTC with SIGNED_OPS = " & to_string(SIGNED_TWO_BOOL) & " passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process stim_gen2;
end architecture behavior;
