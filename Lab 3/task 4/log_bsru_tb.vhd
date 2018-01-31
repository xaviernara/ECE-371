library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity log_bsru_tb is
end entity log_bsru_tb;

architecture behavior of log_bsru_tb is
 
   constant CNT_SIZE1 : positive := 1;
   constant CNT_SIZE2 : positive := 2;
   constant CNT_SIZE3 : positive := 3;
  
   constant DELAY_TIME : delay_length := 1 ns;   
   
   signal in_stim1 : unsigned(2**CNT_SIZE1+CNT_SIZE1+2 downto 0) := (others => '0');
   signal F_dut1, F_gm1 : std_logic_vector(2**CNT_SIZE1-1 downto 0);
   alias right_stim1 : unsigned(0 downto 0) is in_stim1(2**CNT_SIZE1+CNT_SIZE1+2 downto 2**CNT_SIZE1+CNT_SIZE1+2);
   alias shift_stim1 : unsigned(0 downto 0) is in_stim1(2**CNT_SIZE1+CNT_SIZE1+1 downto 2**CNT_SIZE1+CNT_SIZE1+1);
   alias arith_stim1 : unsigned(0 downto 0) is in_stim1(2**CNT_SIZE1+CNT_SIZE1 downto 2**CNT_SIZE1+CNT_SIZE1);
   alias cnt_stim1 : unsigned(CNT_SIZE1-1 downto 0) is in_stim1(2**CNT_SIZE1+CNT_SIZE1-1 downto 2**CNT_SIZE1);
   alias A_stim1 : unsigned(2**CNT_SIZE1-1 downto 0) is in_stim1(2**CNT_SIZE1-1 downto 0);
   
   signal in_stim2 : unsigned(2**CNT_SIZE2+CNT_SIZE2+2 downto 0) := (others => '0');
   signal F_dut2, F_gm2 : std_logic_vector(2**CNT_SIZE2-1 downto 0);
   alias right_stim2 : unsigned(0 downto 0) is in_stim2(2**CNT_SIZE2+CNT_SIZE2+2 downto 2**CNT_SIZE2+CNT_SIZE2+2);
   alias shift_stim2 : unsigned(0 downto 0) is in_stim2(2**CNT_SIZE2+CNT_SIZE2+1 downto 2**CNT_SIZE2+CNT_SIZE2+1);
   alias arith_stim2 : unsigned(0 downto 0) is in_stim2(2**CNT_SIZE2+CNT_SIZE2 downto 2**CNT_SIZE2+CNT_SIZE2);
   alias cnt_stim2 : unsigned(CNT_SIZE2-1 downto 0) is in_stim2(2**CNT_SIZE2+CNT_SIZE2-1 downto 2**CNT_SIZE2);
   alias A_stim2 : unsigned(2**CNT_SIZE2-1 downto 0) is in_stim2(2**CNT_SIZE2-1 downto 0);
 
   signal in_stim3 : unsigned(2**CNT_SIZE3+CNT_SIZE3+2 downto 0) := (others => '0');
   signal F_dut3, F_gm3 : std_logic_vector(2**CNT_SIZE3-1 downto 0);
   alias right_stim3 : unsigned(0 downto 0) is in_stim3(2**CNT_SIZE3+CNT_SIZE3+2 downto 2**CNT_SIZE3+CNT_SIZE3+2);
   alias shift_stim3 : unsigned(0 downto 0) is in_stim3(2**CNT_SIZE3+CNT_SIZE3+1 downto 2**CNT_SIZE3+CNT_SIZE3+1);
   alias arith_stim3 : unsigned(0 downto 0) is in_stim3(2**CNT_SIZE3+CNT_SIZE3 downto 2**CNT_SIZE3+CNT_SIZE3);
   alias cnt_stim3 : unsigned(CNT_SIZE3-1 downto 0) is in_stim3(2**CNT_SIZE3+CNT_SIZE3-1 downto 2**CNT_SIZE3);
   alias A_stim3 : unsigned(2**CNT_SIZE3-1 downto 0) is in_stim3(2**CNT_SIZE3-1 downto 0);

begin

  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (2**CNT_SIZE1)-bit Logarithmic Bidirectional Shifter/Rotator (LogBSRU)
  ------------------------------------------------------------------------------------------
  dut1 : entity work.log_bsru(structure)
  generic map(CNT_SIZE => CNT_SIZE1)
  port map (  A  => std_logic_vector(A_stim1),
              shift => shift_stim1(0),
              arith => arith_stim1(0),
			  right => right_stim1(0),
              cnt => std_logic_vector(cnt_stim1),
       		  F => F_dut1);

  gm1 : entity work.log_bsru_golden(behavior)
  generic map(CNT_SIZE => CNT_SIZE1)
  port map (  A  => std_logic_vector(A_stim1),
              shift => shift_stim1(0),
              arith => arith_stim1(0),
			  right => right_stim1(0),
              cnt => std_logic_vector(cnt_stim1),
              F => F_gm1);
              
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (2**CNT_SIZE2)-bit Logarithmic Bidirectional Shifter/Rotator (LogBSRU)
  ------------------------------------------------------------------------------------------
  dut2 : entity work.log_bsru(structure)
  generic map(CNT_SIZE => CNT_SIZE2)
  port map (  A  => std_logic_vector(A_stim2),
              shift => shift_stim2(0),
              arith => arith_stim2(0),
			  right => right_stim2(0),
              cnt => std_logic_vector(cnt_stim2),
              F => F_dut2);

  gm2 : entity work.log_bsru_golden(behavior)
  generic map(CNT_SIZE => CNT_SIZE2)
  port map (  A  => std_logic_vector(A_stim2),
              shift => shift_stim2(0),
              arith => arith_stim2(0),
			  right => right_stim2(0),
              cnt => std_logic_vector(cnt_stim2),
              F => F_gm2);
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (2**CNT_SIZE3)-bit Logarithmic Bidirectional Shifter/Rotator (LogBSRU)
  ------------------------------------------------------------------------------------------
  dut3 : entity work.log_bsru(structure)
  generic map(CNT_SIZE => CNT_SIZE3)
  port map (  A  => std_logic_vector(A_stim3),
              shift => shift_stim3(0),
              arith => arith_stim3(0),
			  right => right_stim3(0),
              cnt => std_logic_vector(cnt_stim3),
              F => F_dut3);

  gm3 : entity work.log_bsru_golden(behavior)
  generic map(CNT_SIZE => CNT_SIZE3)
  port map (  A  => std_logic_vector(A_stim3),
              shift => shift_stim3(0),
              arith => arith_stim3(0),
			  right => right_stim3(0),
              cnt => std_logic_vector(cnt_stim3),
              F => F_gm3);
  
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for (2**CNT_SIZE1)-bit Logarithmic Bidirectional Shifter/Rotator (LogBSRU)
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is begin
     stim_combos : for i in 0 to 2**in_stim2'length - 1 loop
        if(not((arith_stim1(0) = '1') and (right_stim1(0) = '0'))) then --do not check for arithmetic left shifts
           assert F_dut1 = F_gm1
              report "E@TB: Output missmatch:" & LF &
                     "(shift_stim1) = " & integer'image(to_integer(unsigned(shift_stim1))) & LF &
                     "(right_stim1) = " & integer'image(to_integer(unsigned(right_stim1))) & LF &
                     "(arith_stim1) = " & integer'image(to_integer(unsigned(arith_stim1))) & LF &
   				     "(a_stim1) = " & integer'image(to_integer(unsigned(A_stim1))) & LF &
                     "(cnt_stim1) = " & integer'image(to_integer(unsigned(cnt_stim1))) & LF &
			   	     "(f_dut1) = " & integer'image(to_integer(unsigned(F_dut1))) & LF &
                     "(f_gm1) = " & integer'image(to_integer(unsigned(F_gm1)))
              severity failure;
        end if;
        wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
	 report "@TB: The " & integer'image(2**CNT_SIZE1) & "-bit LogBSRU is fully functional";
     wait;  --suspend this process
  end process stim_gen1;

  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for (2**CNT_SIZE2)-bit Logarithmic Bidirectional Shifter/Rotator (LogBSRU)
  ------------------------------------------------------------------------------------------
  stim_gen2 : process is begin
     stim_combos : for i in 0 to 2**in_stim2'length - 1 loop
        if(not((arith_stim2(0) = '1') and (right_stim2(0) = '0'))) then --do not check for arithmetic left shifts
           assert F_dut2 = F_gm2
              report "E@TB: Output missmatch:" & LF &
                     "(shift_stim2) = " & integer'image(to_integer(unsigned(shift_stim2))) & LF &
                     "(right_stim2) = " & integer'image(to_integer(unsigned(right_stim2))) & LF &
                     "(arith_stim2) = " & integer'image(to_integer(unsigned(arith_stim2))) & LF &
                     "(a_stim2) = " & integer'image(to_integer(unsigned(A_stim2))) & LF &
			         "(cnt_stim2) = " & integer'image(to_integer(unsigned(cnt_stim2))) & LF &
                     "(f_dut2) = " & integer'image(to_integer(unsigned(F_dut2))) & LF &
                     "(f_gm2) = " & integer'image(to_integer(unsigned(F_gm2)))
              severity failure;
        end if;
        wait for DELAY_TIME;
        in_stim2 <= in_stim2 + 1;
     end loop stim_combos;
	 report "@TB: The " & integer'image(2**CNT_SIZE2) & "-bit LogBSRU is fully functional";
     wait;  --suspend this process
  end process stim_gen2;
 
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for (2**CNT_SIZE3)-bit Logarithmic Bidirectional Shifter/Rotator (LogBSRU)
  ------------------------------------------------------------------------------------------
  stim_gen3 : process is begin
     stim_combos : for i in 0 to 2**in_stim3'length - 1 loop
        if(not((arith_stim3(0) = '1') and (right_stim3(0) = '0'))) then --do not check for arithmetic left shifts
           assert F_dut3 = F_gm3
              report "E@TB: Output missmatch:" & LF &
                     "(shift_stim3) = " & integer'image(to_integer(unsigned(shift_stim3))) & LF &       
                     "(right_stim3) = " & integer'image(to_integer(unsigned(right_stim3))) & LF &
                     "(arith_stim3) = " & integer'image(to_integer(unsigned(arith_stim3))) & LF &
                     "(a_stim3) = " & integer'image(to_integer(unsigned(A_stim3))) & LF &
                     "(cnt_stim3) = " & integer'image(to_integer(unsigned(cnt_stim3))) & LF &
				     "(f_dut3) = " & integer'image(to_integer(unsigned(F_dut3))) & LF &
                     "(f_gm3) = " & integer'image(to_integer(unsigned(F_gm3)))
              severity failure;
        end if;
        wait for DELAY_TIME;
        in_stim3 <= in_stim3 + 1;
     end loop stim_combos;
	 report "@TB: The " & integer'image(2**CNT_SIZE3) & "-bit LogBSRU is fully functional";
     wait;  --suspend this process
  end process stim_gen3;
end architecture behavior;
