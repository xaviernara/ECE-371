 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bru_tb is
end entity bru_tb;

architecture behavior of bru_tb is
   constant IN_SIZE1 : positive := 1;
   constant IN_SIZE2 : positive := 4;
   constant IN_SIZE3 : positive := 7;

   constant DELAY_TIME : delay_length := 1 ps;   
   
   signal in_stim1 : unsigned(IN_SIZE1 downto 0) := (others => '0');
   signal y_dut1, y_gm1 : std_logic_vector(IN_SIZE1-1 downto 0);
   alias pass_stim1 : unsigned(0 downto 0) is in_stim1(IN_SIZE1 downto IN_SIZE1);
   alias a_stim1 : unsigned(IN_SIZE1-1 downto 0) is in_stim1(IN_SIZE1-1 downto 0);
   
   signal in_stim2 : unsigned(IN_SIZE2 downto 0) := (others => '0');
   signal y_dut2, y_gm2 : std_logic_vector(IN_SIZE2-1 downto 0);
   alias pass_stim2 : unsigned(0 downto 0) is in_stim2(IN_SIZE2 downto IN_SIZE2);
   alias a_stim2 : unsigned(IN_SIZE2-1 downto 0) is in_stim2(IN_SIZE2-1 downto 0);

   signal in_stim3 : unsigned(IN_SIZE3 downto 0) := (others => '0');
   signal y_dut3, y_gm3 : std_logic_vector(IN_SIZE3-1 downto 0);
   alias pass_stim3 : unsigned(0 downto 0) is in_stim3(IN_SIZE3 downto IN_SIZE3);
   alias a_stim3 : unsigned(IN_SIZE3-1 downto 0) is in_stim3(IN_SIZE3-1 downto 0);
begin
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for IN_SIZE1-bit BRU
  ------------------------------------------------------------------------------------------
  dut1 : entity work.bru(behavior)
  generic map(SIZE => IN_SIZE1)
  port map (  pass => pass_stim1(0),
              a  => std_logic_vector(a_stim1),
              y => y_dut1);

  gm1 : entity work.bru_golden(behavior)
  generic map(SIZE => IN_SIZE1)
  port map (  pass => pass_stim1(0),
              a  => std_logic_vector(a_stim1),
              y => y_gm1);
              
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for IN_SIZE2-bit BRU
  ------------------------------------------------------------------------------------------
  dut2 : entity work.bru(behavior)
  generic map(SIZE => IN_SIZE2 )
  port map (  pass => pass_stim2(0),
              a => std_logic_vector(a_stim2),
              y => y_dut2);

  gm2 : entity work.bru_golden(behavior)
  generic map(SIZE => IN_SIZE2 )
  port map (  pass => pass_stim2(0),
              a  => std_logic_vector(a_stim2),
              y => y_gm2);
              
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for IN_SIZE3-bit BRU
  ------------------------------------------------------------------------------------------
  dut3 : entity work.bru(behavior)
  generic map(SIZE => IN_SIZE3 )
  port map (  pass => pass_stim3(0),
              a  => std_logic_vector(a_stim3),
              y => y_dut3);

  gm3 : entity work.bru_golden(behavior)
  generic map(SIZE => IN_SIZE3 )
  port map (  pass => pass_stim3(0),
              a  => std_logic_vector(a_stim3),
              y => y_gm3);

  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for IN_SIZE1-bit BRU
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
        assert y_dut1 = y_gm1
           report "E@TB: Output missmatch:" & LF &
                  "(pass_stim1) = " & integer'image(to_integer(unsigned(pass_stim1))) & LF &
                  "(a_stim1) = " & integer'image(to_integer(unsigned(a_stim1))) & LF &
                  "(y_dut1) = " & integer'image(to_integer(unsigned(y_dut1))) & LF &
                  "(y_gm1) = " & integer'image(to_integer(unsigned(y_gm1)))
           severity failure;
        wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: The " & integer'image(IN_SIZE1) & "-bit BRU is fully functional";
     wait;  --suspend this process
  end process stim_gen1;

  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for IN_SIZE2-bit BRU
  ------------------------------------------------------------------------------------------
  stim_gen2 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim2'length - 1 loop
        assert y_dut2 = y_gm2
           report "E@TB: Output missmatch:" & LF &
                  "(pass_stim2) = " & integer'image(to_integer(unsigned(pass_stim2))) & LF &
                  "(a_stim2) = " & integer'image(to_integer(unsigned(a_stim2))) & LF &
                  "(y_dut2) = " & integer'image(to_integer(unsigned(y_dut2))) & LF &
                  "(y_gm2) = " & integer'image(to_integer(unsigned(y_gm2)))
           severity failure;
        wait for DELAY_TIME;
        in_stim2 <= in_stim2 + 1;
     end loop stim_combos;
     report "@TB: The " & integer'image(IN_SIZE2) & "-bit BRU is fully functional";
     wait;  --suspend this process
  end process stim_gen2;
 
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for IN_SIZE3-bit BRU
  ------------------------------------------------------------------------------------------
  stim_gen3 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim3'length - 1 loop
        assert y_dut3 = y_gm3
           report "E@TB: Output missmatch:" & LF &
                  "(pass_stim3) = " & integer'image(to_integer(unsigned(pass_stim3))) & LF &
                  "(a_stim3) = " & integer'image(to_integer(unsigned(a_stim3))) & LF &
                  "(y_dut3) = " & integer'image(to_integer(unsigned(y_dut3))) & LF &
                  "(y_gm3) = " & integer'image(to_integer(unsigned(y_gm3)))
           severity failure;
        wait for DELAY_TIME;
        in_stim3 <= in_stim3 + 1;
     end loop stim_combos;
     report "@TB: The " & integer'image(IN_SIZE3) & "-bit BRU is fully functional";
     wait;  --suspend this process
  end process stim_gen3;
end architecture behavior;
