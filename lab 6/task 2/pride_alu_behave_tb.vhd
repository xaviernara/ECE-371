library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity pride_alu_behave_tb is
end entity pride_alu_behave_tb;

architecture behavior of pride_alu_behave_tb is   

    function is_unused_funct(f : unsigned) return boolean is
	   variable isUnused : boolean := false;
     variable funct : unsigned(3 downto 0) := (others => '0');
    begin
     isUnused := false;
	   funct := f;
	   check_op : case funct is
		   when x"8" | x"9" | x"D" =>
			   isUnused := true;
			when others => 
			   isUnused := false;
	   end case check_op;
	   return isUnused;
   end function is_unused_funct;
	
   constant LOG2_SIZE_ONE : positive := 5; 
   constant LOG2_SIZE_TWO : positive := 4 ;
   constant SIZE_ONE : positive := 2**LOG2_SIZE_ONE;
   constant SIZE_TWO : positive := 2**LOG2_SIZE_TWO;
   constant UNUSED_FUNCT_CODE1 : positive := 8;  --"1000"
   constant UNUSED_FUNCT_CODE2 : positive  := 9; --"1001"
   constant UNUSED_FUNCT_CODE3 : positive := 13; --"1101"  
   constant DELAY_TIME : delay_length := 1 ps;
   constant FUNCT_SIZE : positive := 4;
   constant NUM_TEST_CASES : positive := 300000;
   constant MAX_NAT16 : natural := 2**(SIZE_ONE/2)-1;
   constant MAX_NAT4 : natural := 2**FUNCT_SIZE-1;
   
   signal result_dut1, result_gm1 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal result_dut2, result_gm2 : std_logic_vector(SIZE_TWO-1 downto 0) := (others => '0');
   signal NZVC_dut1, NZVC_gm1 : std_logic_vector(3 downto 0) := (others => '0');
   signal NZVC_dut2, NZVC_gm2 : std_logic_vector(3 downto 0) := (others => '0');
   signal funct_stim1 : std_logic_vector(FUNCT_SIZE-1 downto 0) := (others => '0');
   signal funct_stim2 : std_logic_vector(FUNCT_SIZE-1 downto 0) := (others => '0');
   signal x_stim1 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal x_stim2 : std_logic_vector(SIZE_TWO-1 downto 0) := (others => '0');
   signal y_stim1 : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal y_stim2 : std_logic_vector(SIZE_TWO-1 downto 0) := (others => '0');
   alias x_stim1_hi : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim1(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias x_stim1_lo : std_logic_vector((SIZE_ONE/2)-1 downto 0) is x_stim1((SIZE_ONE/2)-1 downto 0);    
   alias y_stim1_hi : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim1(SIZE_ONE-1 downto (SIZE_ONE/2));
   alias y_stim1_lo : std_logic_vector((SIZE_ONE/2)-1 downto 0) is y_stim1((SIZE_ONE/2)-1 downto 0);    

   procedure rand_int( variable seed1, seed2 : inout positive; 
	                   min, max : in integer; 
					   result   : out natural
				      ) 
   is
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
  --  for SIZE_ONE-bit Pride ALU
  ------------------------------------------------------------------------------------------
  gm1 : entity work.pride_alu_golden(golden)
  generic map (LOG2_SIZE => LOG2_SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              funct => std_logic_vector(funct_stim1),
              r => result_gm1,
              NZVC => NZVC_gm1 );

  dut1 : entity work.pride_alu_behave(behavior)
  generic map(LOG2_SIZE => LOG2_SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              funct => std_logic_vector(funct_stim1),
              result => result_dut1,
              NZVC => NZVC_dut1 );

  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit Pride ALU
  ------------------------------------------------------------------------------------------
  gm2 : entity work.pride_alu_golden(golden)
  generic map (LOG2_SIZE => LOG2_SIZE_TWO)
  port map (  x => std_logic_vector(x_stim2),
              y => std_logic_vector(y_stim2),
              funct => std_logic_vector(funct_stim2),
              r => result_gm2,
              NZVC => NZVC_gm2 );

  dut2 : entity work.pride_alu_behave(behavior)
  generic map(LOG2_SIZE => LOG2_SIZE_TWO)
  port map (  x => std_logic_vector(x_stim2),
              y => std_logic_vector(y_stim2),
              funct => std_logic_vector(funct_stim2),
              result => result_dut2,
              NZVC => NZVC_dut2 );

  ------------------------------------------------------------------------------------------ 
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  rand_stim_gen1 : process is 
     variable seed1, seed2 : positive := 68303356; --****CHANGE TO lower 8 digits of your PUID*
 	   variable x_int1_hi     : natural range 0 to MAX_NAT16;
 	   variable x_int1_lo     : natural range 0 to MAX_NAT16;
 	   variable y_int1_hi     : natural range 0 to MAX_NAT16;
 	   variable y_int1_lo     : natural range 0 to MAX_NAT16;
 	   variable funct_int1    : natural range 0 to MAX_NAT4;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
		 wait for DELAY_TIME;
		 if not( is_unused_funct(unsigned(funct_stim1)) ) then
		    assert result_dut1 = result_gm1
			   report "@TB: Output mismatch: " & LF & 
			          "x_stim1 = 0x" & to_hstring(x_stim1) & LF & 
			          "y_stim1 = 0x" & to_hstring(y_stim1) & LF & 
			          "funct_stim1 = 0x" & to_hstring(funct_stim1) & LF & 
			          "result_dut1 = 0x" & to_hstring(result_dut1) & LF & 
			          "result_gm1 = 0x" & to_hstring(result_gm1)
			   severity FAILURE; 
			assert NZVC_dut1 = NZVC_gm1
			   report "@TB: Output mismatch: " & LF & 
			          "x_stim1 = 0x" & to_hstring(x_stim1) & LF & 
			          "y_stim1 = 0x" & to_hstring(y_stim1) & LF & 
			          "funct_stim1 = 0x" & to_hstring(funct_stim1) & LF & 
			          "NZVC_dut1 = 0x" & to_hstring(NZVC_dut1) & LF & 
			          "NZVC_gm1 = 0x" & to_hstring(NZVC_gm1)
			   severity FAILURE; 
		 end if;
         wait for DELAY_TIME;
	     -----------------------------------------------------------
	     --generate random inputs for x_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int1_hi); 
	     x_stim1_hi <= std_logic_vector(to_unsigned( x_int1_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int1_lo); 
	     x_stim1_lo <= std_logic_vector(to_unsigned( x_int1_lo, (SIZE_ONE/2)));
	     -----------------------------------------------------------
	     --generate random inputs for y_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int1_hi); 
	     y_stim1_hi <= std_logic_vector(to_unsigned( y_int1_hi, SIZE_ONE/2));
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int1_lo); 
	     y_stim1_lo <= std_logic_vector(to_unsigned( y_int1_lo, (SIZE_ONE/2)));
	     -----------------------------------------------------------
	     --generate random inputs for funct_stim
	     -----------------------------------------------------------     	     
	     rand_int(seed1, seed2,  0, MAX_NAT4, funct_int1); 
 	     funct_stim1 <= std_logic_vector(to_unsigned( funct_int1, FUNCT_SIZE));
 	     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit Pride ALU passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process rand_stim_gen1;

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_TWO
  ------------------------------------------------------------------------------------------
  rand_stim_gen2 : process is 
     variable seed1, seed2 : positive := 65440485; --****CHANGE TO upper 8 digits of your PUID*
 	   variable x_int2     : natural range 0 to MAX_NAT16;
 	   variable y_int2     : natural range 0 to MAX_NAT16;
 	   variable funct_int2 : natural range 0 to MAX_NAT4;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
		 wait for DELAY_TIME;
		 if not( is_unused_funct(unsigned(funct_stim2)) ) then
		    assert result_dut2 = result_gm2
			   report "@TB: Output mismatch: " & LF & 
			          "x_stim2 = 0x" & to_hstring(x_stim2) & LF & 
			          "y_stim2 = 0x" & to_hstring(y_stim2) & LF & 
			          "funct_stim2 = 0x" & to_hstring(funct_stim2) & LF & 
			          "result_dut2 = 0x" & to_hstring(result_dut2) & LF & 
			          "result_gm2 = 0x" & to_hstring(result_gm2)
			   severity FAILURE; 
			assert NZVC_dut2 = NZVC_gm2
			   report "@TB: Output mismatch: " & LF & 
			          "x_stim2 = 0x" & to_hstring(x_stim2) & LF & 
			          "y_stim2 = 0x" & to_hstring(y_stim2) & LF & 
			          "funct_stim2 = 0x" & to_hstring(funct_stim2) & LF & 
			          "NZVC_dut2 = 0x" & to_hstring(NZVC_dut2) & LF & 
			          "NZVC_gm2 = 0x" & to_hstring(NZVC_gm2)
			   severity FAILURE; 
		 end if;
         wait for DELAY_TIME;
	     -----------------------------------------------------------
	     --generate random inputs for x_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int2); 
	     x_stim2 <= std_logic_vector(to_unsigned( x_int2, SIZE_TWO));
	     -----------------------------------------------------------
	     --generate random inputs for y_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int2); 
	     y_stim2 <= std_logic_vector(to_unsigned( y_int2, SIZE_TWO));
	     -----------------------------------------------------------
	     --generate random inputs for funct_stim
	     -----------------------------------------------------------     	     
	     rand_int(seed1, seed2,  0, MAX_NAT4, funct_int2); 
 	     funct_stim2 <= std_logic_vector(to_unsigned( funct_int2, FUNCT_SIZE));
 	     end loop stim_combos;
     report "@TB: " & to_string(SIZE_TWO) & "-bit Pride ALU passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process rand_stim_gen2;
end architecture behavior;
