library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_fsru_tb is
end entity right_fsru_tb;

architecture behavior of right_fsru_tb is

  constant SIZE_ONE   : positive := 4;
  constant SIZE_TWO   : positive := 8;
  constant SIZE_THREE : positive := 11;
  
  constant CNT_VAL_ONE   : positive := 2;
  constant CNT_VAL_TWO   : positive := 4;
  constant CNT_VAL_THREE : positive := 6;
  
  constant DELAY_TIME : delay_length := 1 ps; 
  
  signal IN_STIM1 : unsigned(SIZE_ONE+2 downto 0) := (others => '0');
  alias en_stim1 : unsigned(0 downto 0) is IN_STIM1(SIZE_ONE+2 downto SIZE_ONE+2);
  alias shift_stim1 : unsigned(0 downto 0) is IN_STIM1(SIZE_ONE+1 downto SIZE_ONE+1);
  alias srin_stim1 : unsigned(0 downto 0) is IN_STIM1(SIZE_ONE downto SIZE_ONE);
  alias A_stim1 : unsigned(SIZE_ONE-1 downto 0) is IN_STIM1(SIZE_ONE-1 downto 0);
  signal F_GM1, F_DUT1 : std_logic_vector(SIZE_ONE-1 downto 0);
  
  signal IN_STIM2 : unsigned(SIZE_TWO+2 downto 0) := (others => '0');
  alias en_stim2 : unsigned(0 downto 0) is IN_STIM2(SIZE_TWO+2 downto SIZE_TWO+2);
  alias shift_stim2 : unsigned(0 downto 0) is IN_STIM2(SIZE_TWO+1 downto SIZE_TWO+1);
  alias srin_stim2 : unsigned(0 downto 0) is IN_STIM2(SIZE_TWO downto SIZE_TWO);
  alias A_stim2 : unsigned(SIZE_TWO-1 downto 0) is IN_STIM2(SIZE_TWO-1 downto 0);
  signal F_GM2, F_DUT2 : std_logic_vector(SIZE_TWO-1 downto 0);
  
  signal IN_STIM3 : unsigned(SIZE_THREE+2 downto 0) := (others => '0');
  alias en_stim3 : unsigned(0 downto 0) is IN_STIM3(SIZE_THREE+2 downto SIZE_THREE+2);
  alias shift_stim3 : unsigned(0 downto 0) is IN_STIM3(SIZE_THREE+1 downto SIZE_THREE+1);
  alias srin_stim3 : unsigned(0 downto 0) is IN_STIM3(SIZE_THREE downto SIZE_THREE);
  alias A_stim3 : unsigned(SIZE_THREE-1 downto 0) is IN_STIM3(SIZE_THREE-1 downto 0);
  signal F_GM3, F_DUT3 : std_logic_vector(SIZE_THREE-1 downto 0);
  
  begin
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for SIZE_ONE-bit FSRU
  ------------------------------------------------------------------------------------------
  dut1 : entity work.right_fsru(mixed)
  generic map(SIZE => SIZE_ONE,
              CNT_VAL => CNT_VAL_ONE)
  port map (  A  => std_logic_vector(A_stim1),
              en => en_stim1(0),
              shift => shift_stim1(0),
              srin => srin_stim1(0),
           	  F => F_dut1);

  gm1 : entity work.right_fsru_golden(behavior)
  generic map(SIZE => SIZE_ONE,
              CNT_VAL => CNT_VAL_ONE)
  port map (  A    => std_logic_vector(A_stim1),
              en   => en_stim1(0),
              shift  => shift_stim1(0),
              srin => srin_stim1(0),
              F    => F_gm1);
              
  ---------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for SIZE_TWO-bit FSRU
  ------------------------------------------------------------------------------------------
  dut2 : entity work.right_fsru(mixed)
  generic map(SIZE => SIZE_TWO,
              CNT_VAL => CNT_VAL_TWO)
  port map (  A    => std_logic_vector(A_stim2),
              en   => en_stim2(0),
              shift  => shift_stim2(0),
              srin => srin_stim2(0),
           	  F    => F_dut2);

  gm2 : entity work.right_fsru_golden(behavior)
  generic map(SIZE => SIZE_TWO,
              CNT_VAL => CNT_VAL_TWO)
  port map (  A    => std_logic_vector(A_stim2),
              en   => en_stim2(0),
              shift  => shift_stim2(0),
              srin => srin_stim2(0),
              F    => F_gm2);
    
  ---------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for SIZE_THREE-bit FSRU
  ------------------------------------------------------------------------------------------
  dut3 : entity work.right_fsru(mixed)
  generic map(SIZE => SIZE_THREE,
              CNT_VAL => CNT_VAL_THREE)
  port map (  A    => std_logic_vector(A_stim3),
              en   => en_stim3(0),
              shift  => shift_stim3(0),
              srin => srin_stim3(0),
           	  F    => F_dut3);

  gm3 : entity work.right_fsru_golden(behavior)
  generic map(SIZE => SIZE_THREE,
              CNT_VAL => CNT_VAL_THREE)
  port map (  A    => std_logic_vector(A_stim3),
              en   => en_stim3(0),
              shift  => shift_stim3(0),
              srin => srin_stim3(0),
              F    => F_gm3);  
  
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for SIZE_ONE-bit sru
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
        assert F_dut1 = F_gm1
           report "E@TB: Output missmatch:" & LF &
                  "(en_stim1) = " & integer'image(to_integer(unsigned(en_stim1))) & LF &
                  "(shift_stim1) = " & integer'image(to_integer(unsigned(shift_stim1))) & LF &
                  "(srin_stim1) = " & integer'image(to_integer(unsigned(srin_stim1))) & LF &
                  "(A_stim1) = " & integer'image(to_integer(unsigned(A_stim1))) & LF &
				  "(F_dut1) = " & integer'image(to_integer(unsigned(F_dut1))) & LF &
                  "(F_gm1) = " & integer'image(to_integer(unsigned(F_gm1)))
           severity failure;
        wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
	 report "@TB: The " & integer'image(SIZE_ONE) & "-bit Right Fixed Shift/Rotate Unit (FSRU) is fully functional";
     wait;  --suspend this process
  end process stim_gen1;
  
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for SIZE_TWO-bit FSRU
  ------------------------------------------------------------------------------------------
  stim_gen2 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim2'length - 1 loop
        assert F_dut2 = F_gm2
           report "E@TB: Output missmatch:" & LF &
                  "(en_stim2) = " & integer'image(to_integer(unsigned(en_stim2))) & LF &
                  "(shift_stim2) = " & integer'image(to_integer(unsigned(shift_stim2))) & LF &
                  "(srin_stim2) = " & integer'image(to_integer(unsigned(srin_stim2))) & LF &
                  "(A_stim2) = " & integer'image(to_integer(unsigned(A_stim2))) & LF &
				  "(F_dut2) = " & integer'image(to_integer(unsigned(F_dut2))) & LF &
                  "(F_gm2) = " & integer'image(to_integer(unsigned(F_gm2)))
           severity failure;
        wait for DELAY_TIME;
        in_stim2 <= in_stim2 + 1;
     end loop stim_combos;
	 report "@TB: The " & integer'image(SIZE_TWO) & "-bit Right Fixed Shift/Rotate Unit (FSRU) is fully functional";
     wait;  --suspend this process
  end process stim_gen2;
  
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for SIZE_THREE-bit sru
  ------------------------------------------------------------------------------------------
  stim_gen3 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim3'length - 1 loop
        assert F_dut3 = F_gm3
           report "E@TB: Output missmatch:" & LF &
                  "(en_stim3) = " & integer'image(to_integer(unsigned(en_stim3))) & LF &
                  "(shift_stim3) = " & integer'image(to_integer(unsigned(shift_stim3))) & LF &
                  "(srin_stim3) = " & integer'image(to_integer(unsigned(srin_stim3))) & LF &
                  "(A_stim3) = " & integer'image(to_integer(unsigned(A_stim3))) & LF &
				  "(F_dut3) = " & integer'image(to_integer(unsigned(F_dut3))) & LF &
                  "(F_gm3) = " & integer'image(to_integer(unsigned(F_gm3)))
           severity failure;
        wait for DELAY_TIME;
        in_stim3 <= in_stim3 + 1;
     end loop stim_combos;
	 report "@TB: The " & integer'image(SIZE_THREE) & "-bit Right Fixed Shift/Rotate Unit (FSRU) is fully functional";
     wait;  --suspend this process
  end process stim_gen3;
    
  end architecture behavior;
