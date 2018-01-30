 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elu_tb is
end entity elu_tb;

architecture behavior of elu_tb is
   constant IN_SIZE1 : positive := 4;
   constant IN_SIZE2 : positive := 3;
   constant IN_SIZE3 : positive := 8;
   
   constant OUT_SIZE1 : positive := 4;
   constant OUT_SIZE2 : positive := 6;
   constant OUT_SIZE3 : positive := 16;

   constant DELAY_TIME : delay_length := 1 ps;   
   
   signal in_stim1 : unsigned(IN_SIZE1 downto 0) := (others => '0');
   signal y_dut1, y_gm1 : std_logic_vector(OUT_SIZE1-1 downto 0);
   alias arith_stim1 : unsigned(0 downto 0) is in_stim1(IN_SIZE1 downto IN_SIZE1);
   alias A_stim1 : unsigned(IN_SIZE1-1 downto 0) is in_stim1(IN_SIZE1-1 downto 0);
   
   signal in_stim2 : unsigned(IN_SIZE2 downto 0) := (others => '0');
   signal y_dut2, y_gm2 : std_logic_vector(OUT_SIZE2-1 downto 0);
   alias arith_stim2 : unsigned(0 downto 0) is in_stim2(IN_SIZE2 downto IN_SIZE2);
   alias A_stim2 : unsigned(IN_SIZE2-1 downto 0) is in_stim2(IN_SIZE2-1 downto 0);

   signal in_stim3 : unsigned(IN_SIZE3 downto 0) := (others => '0');
   signal y_dut3, y_gm3 : std_logic_vector(OUT_SIZE3-1 downto 0);
   alias arith_stim3 : unsigned(0 downto 0) is in_stim3(IN_SIZE3 downto IN_SIZE3);
   alias A_stim3 : unsigned(IN_SIZE3-1 downto 0) is in_stim3(IN_SIZE3-1 downto 0);
begin
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (IN_SIZE1, OUT_SIZE1) ELU
  ------------------------------------------------------------------------------------------
  dut1 : entity work.elu(dataflow)
  generic map(ISIZE => IN_SIZE1, OSIZE => OUT_SIZE1 )
  port map (  arith => arith_stim1(0),
              A  => std_logic_vector(A_stim1),
              Y => y_dut1);

  gm1 : entity work.elu_golden(behavior)
  generic map(ISIZE => IN_SIZE1, OSIZE => OUT_SIZE1 )
  port map (  arith => arith_stim1(0),
              A  => std_logic_vector(A_stim1),
              Y => y_gm1);
              
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (IN_SIZE2, OUT_SIZE2) ELU
  ------------------------------------------------------------------------------------------
  dut2 : entity work.elu(dataflow)
  generic map(ISIZE => IN_SIZE2, OSIZE => OUT_SIZE2 )
  port map (  arith => arith_stim2(0),
              A  => std_logic_vector(A_stim2),
              Y => y_dut2);

  gm2 : entity work.elu_golden(behavior)
  generic map(ISIZE => IN_SIZE2, OSIZE => OUT_SIZE2 )
  port map (  arith => arith_stim2(0),
              A  => std_logic_vector(A_stim2),
              Y => y_gm2);
              
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (IN_SIZE3, OUT_SIZE3) ELU
  ------------------------------------------------------------------------------------------
  dut3 : entity work.elu(dataflow)
  generic map(ISIZE => IN_SIZE3, OSIZE => OUT_SIZE3 )
  port map (  arith => arith_stim3(0),
              A  => std_logic_vector(A_stim3),
              Y => y_dut3);

  gm3 : entity work.elu_golden(behavior)
  generic map(ISIZE => IN_SIZE3, OSIZE => OUT_SIZE3 )
  port map (  arith => arith_stim3(0),
              A  => std_logic_vector(A_stim3),
              Y => y_gm3);

  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for (IN_SIZE1, OUT_SIZE1) ELU
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
        assert y_dut1 = y_gm1
           report "E@TB: Output missmatch:" & LF &
                  "(arith_stim1) = " & integer'image(to_integer(unsigned(arith_stim1))) & LF &
                  "(A_stim1) = " & integer'image(to_integer(unsigned(A_stim1))) & LF &
                  "(y_dut1) = " & integer'image(to_integer(unsigned(y_dut1))) & LF &
                  "(y_gm1) = " & integer'image(to_integer(unsigned(y_gm1)))
           severity failure;
        wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: (" & integer'image(IN_SIZE1) & "," & integer'image(OUT_SIZE1) & ") ELU is fully functional";
     wait;  --suspend this process
  end process stim_gen1;

  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for (IN_SIZE2, OUT_SIZE2) ELU
  ------------------------------------------------------------------------------------------
  stim_gen2 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim2'length - 1 loop
        assert y_dut2 = y_gm2
           report "E@TB: Output missmatch:" & LF &
                  "(arith_stim2) = " & integer'image(to_integer(unsigned(arith_stim2))) & LF &
                  "(A_stim2) = " & integer'image(to_integer(unsigned(A_stim2))) & LF &
                  "(y_dut2) = " & integer'image(to_integer(unsigned(y_dut2))) & LF &
                  "(y_gm2) = " & integer'image(to_integer(unsigned(y_gm2)))
           severity failure;
        wait for DELAY_TIME;
        in_stim2 <= in_stim2 + 1;
     end loop stim_combos;
     report "@TB: (" & integer'image(IN_SIZE2) & "," & integer'image(OUT_SIZE2) & ") ELU is fully functional";
     wait;  --suspend this process
  end process stim_gen2;
 
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for (IN_SIZE3, OUT_SIZE3) ELU
  ------------------------------------------------------------------------------------------
  stim_gen3 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim3'length - 1 loop
        assert y_dut3 = y_gm3
           report "E@TB: Output missmatch:" & LF &
                  "(arith_stim3) = " & integer'image(to_integer(unsigned(arith_stim3))) & LF &
                  "(A_stim3) = " & integer'image(to_integer(unsigned(A_stim3))) & LF &
                  "(y_dut3) = " & integer'image(to_integer(unsigned(y_dut3))) & LF &
                  "(y_gm3) = " & integer'image(to_integer(unsigned(y_gm3)))
           severity failure;
        wait for DELAY_TIME;
        in_stim3 <= in_stim3 + 1;
     end loop stim_combos;
     report "@TB: (" & integer'image(IN_SIZE3) & "," & integer'image(OUT_SIZE3) & ") ELU is fully functional";
     wait;  --suspend this process
  end process stim_gen3;
end architecture behavior;
