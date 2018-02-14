library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity asu_32bit_tb is
end entity asu_32bit_tb;

architecture behavior of asu_32bit_tb is   
   constant SIZE_ONE : positive := 32;
   constant DELAY_TIME : delay_length := 1 ps;
   constant NUM_TEST_CASES : positive := 300000;
   constant MAX_NAT16 : natural := 2**(SIZE_ONE/2)-1;
   
   signal NZVC_Result_dut, NZVC_Result_gm : std_logic_vector(SIZE_ONE+3 downto 0) := (others => '0');
   signal sub_stim : std_logic_vector(0 downto 0) := (others => '0');
   signal arith_stim : std_logic_vector(0 downto 0) := (others => '0');
   signal x_stim : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal y_stim : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   alias x_stim_hi : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias x_stim_lo : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim((SIZE_ONE/2)-1 downto 0);    
   alias y_stim_hi : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias y_stim_lo : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim((SIZE_ONE/2)-1 downto 0);    
   alias NZVC_dut : std_logic_vector(3 downto 0) is NZVC_Result_dut(SIZE_ONE+3 downto SIZE_ONE);
   alias NZVC_gm : std_logic_vector(3 downto 0) is NZVC_Result_gm(SIZE_ONE+3 downto SIZE_ONE);
   alias result_dut : std_logic_vector(SIZE_ONE-1 downto 0) is NZVC_Result_dut(SIZE_ONE-1 downto 0);
   alias result_gm : std_logic_vector(SIZE_ONE-1 downto 0) is NZVC_Result_gm(SIZE_ONE-1 downto 0);

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
  --  for SIZE_ONE-bit ASU
  ------------------------------------------------------------------------------------------
  gm1 : entity work.asu_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim),
              y => std_logic_vector(y_stim),
              arith => arith_stim(0),
              sub => sub_stim(0),
              R => Result_gm,
              NZVC => NZVC_gm );

  dut1 : entity work.asu_32bit(mixed)
  port map (  x => std_logic_vector(x_stim),
              y => std_logic_vector(y_stim),
              arith => arith_stim(0),
              sub => sub_stim(0),
              Result => Result_dut,
              NZVC => NZVC_dut );

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  stim_gen : process is 
  	  variable seed1, seed2 : positive := 39537874; --any number will do. Different seed value changes the sequence.
 	   variable x_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable x_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_hi     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable y_int_lo     : natural range 0 to 2**(SIZE_ONE/2)-1;
 	   variable sub_int      : natural range 0 to 1;
 	   variable arith_int : natural range 0 to 1;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
         wait for DELAY_TIME;
		 assert (result_dut = result_gm)
            report "@TB: Output missmatch:" & LF &
                   "(arith_stim) = " & to_string(arith_stim) & LF &
                   "(sub_stim) = " & to_string(sub_stim) & LF &
                   "(x_stim) = 0x" & to_hstring(x_stim) & LF &
                   "(y_stim) = 0x" & to_hstring(y_stim) & LF &
				   "(result_dut) 0x= " & to_hstring(result_dut) & LF &
                   "(result_gm) = 0x" & to_hstring(result_gm)
            severity failure;
         assert (NZVC_dut = NZVC_gm)
           report "@TB: Output missmatch:" & LF &
                  "(arith_stim) = " & to_string(arith_stim) & LF &
                  "(sub_stim) = " & to_string(sub_stim) & LF &
                  "(x_stim) = 0x" & to_hstring(x_stim) & LF &
                  "(y_stim) = 0x" & to_hstring(y_stim) & LF &
				  "(NZVC_dut) = 0x" & to_hstring(NZVC_dut) & LF &
                  "(NZVC_gm) = 0x" & to_hstring(NZVC_gm)
           severity failure ;
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
	     --generate random inputs for sub_stim
	     -----------------------------------------------------------     	     
	     rand_int(seed1, seed2,  0, 1, sub_int); 
 	     sub_stim <= std_logic_vector(to_unsigned( sub_int, 1));
 	     	     -----------------------------------------------------------
	     --generate random inputs for arith_stim
	     -----------------------------------------------------------     	     
	     rand_int(seed1, seed2,  0, 1, arith_int); 
 	     arith_stim <= std_logic_vector(to_unsigned( arith_int, 1));     
     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit ASU passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process stim_gen;
end architecture behavior;
