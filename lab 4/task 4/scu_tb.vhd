library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scu_tb is
end entity scu_tb;

architecture behavior of scu_tb is
   constant SIZE_ONE : positive := 8;
   constant MESSAGE_STRING : string(1 to 23) := "SCU is fully functional";
   constant DELAY_TIME : delay_length := 1 ps;
   
   signal in_stim1 : unsigned(2*SIZE_ONE downto 0) := (others => '0');
   signal z_GSE_dut1 : std_logic_vector(2 downto 0) := (others => '0');
   signal z_GSE_gm1 : std_logic_vector(2 downto 0) := (others => '0');
   alias arith_stim1 : unsigned(0 downto 0) is in_stim1(2*SIZE_ONE downto 2*SIZE_ONE);
   alias x_stim1 : unsigned(SIZE_ONE-1 downto 0) is in_stim1(2*SIZE_ONE - 1 downto SIZE_ONE);
   alias y_stim1 : unsigned(SIZE_ONE-1 downto 0) is in_stim1(SIZE_ONE - 1 downto 0);   
   signal NZVC_gm1 : std_logic_vector(3 downto 0) := (others => '0');
begin
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit Subtraction Comparison Unit (SCU)
  ------------------------------------------------------------------------------------------
  gm1 : entity work.compare_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              arith => arith_stim1(0),
              z_GSE => z_GSE_gm1,
              cinE => '1', cinG => '0', cinS => '0' );
              
  asu_gm1 : entity work.asu_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim1),
              y => std_logic_vector(y_stim1),
              arith => arith_stim1(0),
              sub => '1',
              R => open,
			  NZVC => NZVC_gm1 );
  
  scu_dut1 : entity work.scu(mixed)
  port map (  NZVC => std_logic_vector(NZVC_gm1),
              arith => arith_stim1(0),
              z_GSE => z_GSE_dut1 );

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE Subtraction Comparison Unit (SCU) 
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
        wait for DELAY_TIME;
		if arith_stim1(0) = '0' then
		   assert (z_GSE_dut1 = z_GSE_gm1)
			  report "E@TB: Output missmatch" & LF &
					 "(arith_stim1) = " & integer'image(to_integer(unsigned(arith_stim1))) & LF &
					 "(x_stim1) = " & integer'image(to_integer(unsigned(x_stim1))) & LF &
					 "(y_stim1) = " & integer'image(to_integer(unsigned(y_stim1))) & LF &
					 "(z_GSE_dut1) = " & integer'image(to_integer(unsigned(z_GSE_dut1))) & LF &
					 "(z_GSE_gm1) = " & integer'image(to_integer(unsigned(z_GSE_gm1)))
			  severity failure;
		 else 
		   assert (z_GSE_dut1 = z_GSE_gm1)
			  report "E@TB: Output missmatch" & LF &
					 "(arith_stim1) = " & integer'image(to_integer(unsigned(arith_stim1))) & LF &
					 "(x_stim1) = " & integer'image(to_integer(signed(x_stim1))) & LF &
					 "(y_stim1) = " & integer'image(to_integer(signed(y_stim1))) & LF &
					 "(z_GSE_dut1) = " & integer'image(to_integer(unsigned(z_GSE_dut1))) & LF &
					 "(z_GSE_gm1) = " & integer'image(to_integer(unsigned(z_GSE_gm1)))
			  severity failure;
		end if;
--      wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: " & MESSAGE_STRING;
     wait;  --suspend this process
  end process stim_gen1;
end architecture behavior;
