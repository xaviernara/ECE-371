library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpc_2bit_tb is
end entity cpc_2bit_tb;

architecture behavior of cpc_2bit_tb is
   
   constant SIZE_ONE : positive := 2;
   constant SIGNED_ONE_BOOL : boolean := true;
   constant SIGNED_ONE_STL : std_logic := '1';
   
   constant SIGNED_TWO_BOOL : boolean := false;
   constant SIGNED_TWO_STL : std_logic := '0';
   constant DELAY_TIME : delay_length := 1 ps;
   
   signal in_stim1 : unsigned(2*SIZE_ONE-1 downto 0) := (others => '0');
   signal z_GSE_dut1, z_GSE_dut2 : std_logic_vector(2 downto 0) := (others => '0');
   signal z_GSE_gm1, z_GSE_gm2 : std_logic_vector(2 downto 0) := (others => '0'); 

   alias y_stim1 : unsigned(SIZE_ONE-1 downto 0) is in_stim1(2*SIZE_ONE - 1 downto SIZE_ONE);
   alias x_stim1 : unsigned(SIZE_ONE-1 downto 0) is in_stim1(SIZE_ONE - 1 downto 0); 
begin
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit CPC with SIGNED_OP = SIGNED_ONE_BOOL
  ------------------------------------------------------------------------------------------
  gm1 : entity work.compare_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              arith => SIGNED_ONE_STL,
              cinE => '1', 
              cinG => '0', 
              cinS => '0',
              z_GSE => z_GSE_gm1 );
  
  dut1 : entity work.cpc_2bit(dataflow)
  generic map( SIGNED_OPS => SIGNED_ONE_BOOL )
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              z_GSE => z_GSE_dut1 );

  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit CPC with SIGNED_OP = SIGNED_TWO_BOOL
  ------------------------------------------------------------------------------------------
  gm2 : entity work.compare_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              arith => SIGNED_TWO_STL,
              cinE => '1', 
              cinG => '0', 
              cinS => '0',
              z_GSE => z_GSE_gm2 );
  
  dut2 : entity work.cpc_2bit(dataflow)
  generic map( SIGNED_OPS => SIGNED_TWO_BOOL )
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              z_GSE => z_GSE_dut2 );
                
  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
       wait for DELAY_TIME;
       assert (z_GSE_dut1 = z_GSE_gm1)
		  report "@TB: Output mismatch" & LF &
				 "(SIGNED_OPS) = " & boolean'image(SIGNED_ONE_BOOL) & LF &
				 "(x_stim1) = " & integer'image(to_integer(signed(x_stim1))) & LF &
				 "(y_stim1) = " & integer'image(to_integer(signed(y_stim1))) & LF &
				 "(z_GSE_dut1) = " & integer'image(to_integer(unsigned(z_GSE_dut1))) & LF &
				 "(z_GSE_gm1) = " & integer'image(to_integer(unsigned(z_GSE_gm1)))
		  severity failure;
		assert (z_GSE_dut2 = z_GSE_gm2)
		  report "@TB: Output mismatch" & LF &
				 "(SIGNED_OPS) = " & boolean'image(SIGNED_TWO_BOOL) & LF &
				 "(x_stim1) = " & integer'image(to_integer(unsigned(x_stim1))) & LF &
				 "(y_stim1) = " & integer'image(to_integer(unsigned(y_stim1))) & LF &
				 "(z_GSE_dut2) = " & integer'image(to_integer(unsigned(z_GSE_dut2))) & LF &
				 "(z_GSE_gm2) = " & integer'image(to_integer(unsigned(z_GSE_gm2)))
	   severity failure;
--       wait for DELAY_TIME;
       in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: " & integer'image(SIZE_ONE) & "-bit Unsigned CPC is fully functional";
     report "@TB: " & integer'image(SIZE_ONE) & "-bit Signed CPC is fully functional";
     wait;  --suspend this process
  end process stim_gen1;
end architecture behavior;
