library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity combo_count_94_tb is
end combo_count_94_tb;

architecture behavior of combo_count_94_tb is
   constant P1_SIZE : positive := 9;
   constant Q1_SIZE : positive := positive(ceil(log2(real(P1_SIZE+1))));
   constant DELAY_TIME : delay_length := 1 ps;
   
   signal in_stim1 : unsigned(P1_SIZE-1 downto 0) := (others => '0');
   signal y_dut1, y_gm1 : std_logic_vector(Q1_SIZE-1 downto 0);
   alias x_stim1 : unsigned(P1_SIZE-1 downto 0) is in_stim1(P1_SIZE-1 downto 0);
begin
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for (p,q) = (P1_SIZE,Q1_SIZE) combinational counters
  ------------------------------------------------------------------------------------------
  gm1 : entity work.combo_count_golden(behavior)
  generic map (P => P1_SIZE)
  port map ( x => std_logic_vector(x_stim1),
             y => y_gm1 );

  dut1 : entity work.combo_count_94(structure)
  port map ( x => std_logic_vector(x_stim1),
             y => y_dut1 );

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design-under-test (DUT)
  --  model for (p,q) = (P1_SIZE,Q1_SIZE) 
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
        assert y_dut1 = y_gm1
           report "@TB: Output missmatch:" & LF &
                  "(x_stim1) = " & integer'image(to_integer(x_stim1)) & LF &
                  "(y_dut1) = " & integer'image(to_integer(unsigned(y_dut1))) & LF &
                  "(y_gm1) = " & integer'image(to_integer(unsigned(y_gm1)))
           severity failure;
        wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: The (" & integer'image(P1_SIZE) & ", " & integer'image(Q1_SIZE) & ") combinational counter is fully functional"; 
     wait;  --suspend this process
  end process stim_gen1;
end architecture behavior;
