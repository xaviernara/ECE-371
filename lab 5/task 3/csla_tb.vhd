library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity csla_tb is
end entity csla_tb;

architecture behavior of csla_tb is
   constant NUM_TEST_CASES : positive := 300000;
   constant GROUP_SIZE : positive := 8;
   constant NUM_GROUPS_ONE : positive := 1;
   constant NUM_GROUPS_TWO : positive := 2;
   constant SIZE_ONE : positive := NUM_GROUPS_ONE * GROUP_SIZE; --8-bits
   constant SIZE_TWO : positive := NUM_GROUPS_TWO * GROUP_SIZE; --16-bits
   constant MAX_NAT16 : natural := 2**(SIZE_TWO)-1;
   constant DELAY_TIME : delay_length := 1 ps;

   signal in_stim1 : unsigned(2*SIZE_ONE downto 0) := (others => '0');
   signal Cout_Sum_dut1, Cout_Sum_gm1 : std_logic_vector(SIZE_ONE downto 0) := (others => '0');
   alias cin_stim1 : unsigned(0 downto 0) is in_stim1(2*SIZE_ONE downto 2*SIZE_ONE);
   alias x_stim1 : unsigned(SIZE_ONE-1 downto 0) is in_stim1(2*SIZE_ONE - 1 downto SIZE_ONE);
   alias y_stim1 : unsigned(SIZE_ONE-1 downto 0) is in_stim1(SIZE_ONE - 1 downto 0);

   signal x_stim2 : std_logic_vector(SIZE_TWO-1 downto 0) := (others => '0');
   signal y_stim2 : std_logic_vector(SIZE_TWO-1 downto 0) := (others => '0');
   signal cin_stim2 : std_logic_vector(0 downto 0) := (others => '0');
   signal Cout_Sum_dut2, Cout_Sum_gm2 : std_logic_vector(SIZE_TWO downto 0) := (others => '0');

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
  --  for SIZE_ONE-bit CSLA
  ------------------------------------------------------------------------------------------
  gm1_add : entity work.adder_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              Cin => Cin_stim1(0),
              Sum => Cout_Sum_gm1(SIZE_ONE - 1 downto 0),
              Cout => Cout_Sum_gm1(SIZE_ONE) );
    
  dut1 : entity work.csla(structure)
  generic map (NUM_GROUPS => NUM_GROUPS_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              Cin => Cin_stim1(0),
              Sum => Cout_Sum_dut1(SIZE_ONE - 1 downto 0),
              Cout => Cout_Sum_dut1(SIZE_ONE) );
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_TWO-bit CSLA
  ------------------------------------------------------------------------------------------
  gm2_add : entity work.adder_golden(golden)
  generic map (SIZE => SIZE_TWO)
  port map (  x => std_logic_vector(x_stim2),
              y => std_logic_vector(y_stim2),
              Cin => Cin_stim2(0),
              Sum => Cout_Sum_gm2(SIZE_TWO - 1 downto 0),
              Cout => Cout_Sum_gm2(SIZE_TWO) );
  
  dut2 : entity work.csla(structure)
  generic map (NUM_GROUPS => NUM_GROUPS_TWO)
  port map (  x => std_logic_vector(x_stim2),
              y => std_logic_vector(y_stim2),
              Cin => Cin_stim2(0),
              
			  Sum => Cout_Sum_dut2(SIZE_TWO - 1 downto 0),
              Cout => Cout_Sum_dut2(SIZE_TWO) );

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
       wait for DELAY_TIME;
       assert (Cout_Sum_dut1 = Cout_Sum_gm1)
          report "@TB: Output missmatch:" & LF &
                 "(x_stim1) = 0x" & to_hstring(x_stim1) & LF & 
                 "(y_stim1) = 0x" & to_hstring(y_stim1) & LF & 
                 "(Cin_stim1) = 0x" & to_hstring(cin_stim1) & LF & 
                 "(Cout_Sum_dut1) = 0x" & to_hstring(cout_sum_dut1) & LF & 
                 "(Cout_Sum_gm1) = 0x" & to_hstring(cout_sum_gm1) 
          severity failure;
       wait for DELAY_TIME;
       in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit CSLA is fully functional";
     wait;  --suspend this process
  end process stim_gen1;

  rand_stim_gen2 : process is 
       variable seed1, seed2 : positive := 68303356; --****CHANGE TO lower 8 digits of your PUID*
 	   variable x_int2_hi : natural range 0 to MAX_NAT16;
 	   variable y_int2_hi : natural range 0 to MAX_NAT16;
 	   variable cin_int2  : natural range 0 to 1;
  begin
     stim_combos : for i in 0 to NUM_TEST_CASES loop
       wait for DELAY_TIME;
       assert (Cout_Sum_dut2 = Cout_Sum_gm2)
          report "@TB: Output missmatch:" & LF &
                 "(x_stim2) = 0x" & to_hstring(x_stim2) & LF & 
                 "(y_stim2) = 0x" & to_hstring(y_stim2) & LF & 
                 "(Cin_stim2) = 0x" & to_hstring(cin_stim2) & LF & 
                 "(Cout_Sum_dut2) = 0x" & to_hstring(cout_sum_dut2) & LF & 
                 "(Cout_Sum_gm2) = 0x" & to_hstring(cout_sum_gm2) 
          severity failure;
        wait for DELAY_TIME;
	     -----------------------------------------------------------
	     --generate random inputs for x_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, x_int2_hi); 
	     x_stim2 <= std_logic_vector(to_unsigned( x_int2_hi, SIZE_TWO));
	     -----------------------------------------------------------
	     --generate random inputs for y_stim
	     -----------------------------------------------------------
	     rand_int(seed1, seed2,  0, MAX_NAT16, y_int2_hi); 
	     y_stim2 <= std_logic_vector(to_unsigned( y_int2_hi, SIZE_TWO));	    
		 -----------------------------------------------------------
	     --generate random inputs for cin_stim
	     -----------------------------------------------------------     	     
	     rand_int(seed1, seed2, 0, 1, cin_int2); 
 	     cin_stim2 <= std_logic_vector(to_unsigned( cin_int2, 1));
 	     end loop stim_combos;
     report "@TB: " & to_string(SIZE_TWO) & "-bit CSLA passes " & to_string(NUM_TEST_CASES) & " random test cases";
     wait;  --suspend this process
  end process rand_stim_gen2;
end architecture behavior;
