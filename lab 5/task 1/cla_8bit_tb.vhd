library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cla_8bit_tb is
end entity cla_8bit_tb;

architecture behavior of cla_8bit_tb is
   constant SIZE_ONE : positive := 8;
   constant DELAY_TIME : delay_length := 1 ps;
   signal in_stim : unsigned(2*SIZE_ONE downto 0) := (others => '0');
   signal g_stim, a_stim : std_logic_vector(SIZE_ONE-1 downto 0) := (others => '0');
   signal Cout_Sum_dut, Cout_Sum_gm : std_logic_vector(SIZE_ONE downto 0) := (others => '0');
   signal GG_GA_dut, GG_GA_gm : std_logic_vector(1 downto 0) := (others => '0');
   alias Cin_stim : unsigned(0 downto 0) is in_stim(2*SIZE_ONE downto 2*SIZE_ONE);
   alias x_stim : unsigned(SIZE_ONE-1 downto 0) is in_stim(2*SIZE_ONE - 1 downto SIZE_ONE);
   alias y_stim : unsigned(SIZE_ONE-1 downto 0) is in_stim(SIZE_ONE - 1 downto 0);
begin
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  --  for SIZE_ONE-bit multi-level CLA
  ------------------------------------------------------------------------------------------
  gm1_add : entity work.adder_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  x => std_logic_vector(x_stim),
              y => std_logic_vector(y_stim),
              Cin => Cin_stim(0),
              Sum => Cout_Sum_gm(SIZE_ONE - 1 downto 0),
              Cout => Cout_Sum_gm(SIZE_ONE) );
  
  g_stim <= std_logic_vector(x_stim and y_stim);
  a_stim <= std_logic_vector(x_stim or y_stim);
  
  gm1_clg : entity work.clg_golden(golden)
  generic map (SIZE => SIZE_ONE)
  port map (  c0 => Cin_stim(0),
              g => g_stim, p => a_stim,
              c => open,
              GG => GG_GA_gm(1),
              GP => GG_GA_gm(0) );

  dut1 : entity work.cla_8bit(structure)
  port map (  x => std_logic_vector(x_stim),
              y => std_logic_vector(y_stim),
              Cin => Cin_stim(0),
              Sum => Cout_Sum_dut(SIZE_ONE - 1 downto 0),
               Cout => Cout_Sum_dut(SIZE_ONE),
              GG => GG_GA_dut(1),
              GA => GG_GA_dut(0) );
  
  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  --  for size SIZE_ONE
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is begin
     stim_combos : for i in 0 to 2**in_stim'length - 1 loop
       wait for DELAY_TIME;
       assert (Cout_Sum_dut = Cout_Sum_gm)
          report "@TB: Output missmatch:" & LF &
                 "(x_stim) = 0x" & to_hstring(x_stim) & LF & 
                 "(y_stim) = 0x" & to_hstring(y_stim) & LF & 
                 "(Cin_stim) = 0x" & to_hstring(cin_stim) & LF & 
                 "(Cout_Sum_dut) = 0x" & to_hstring(cout_sum_dut) & LF & 
                 "(Cout_Sum_gm) = 0x" & to_hstring(cout_sum_gm) 
          severity failure;
       assert (GG_GA_dut = GG_GA_gm)
          report "@TB: Output missmatch:" & LF &
                 "(x_stim) = 0x" & to_hstring(x_stim) & LF & 
                 "(y_stim) = 0x" & to_hstring(y_stim) & LF & 
                 "(Cin_stim) = 0x" & to_hstring(cin_stim) & LF & 
                 "(GG_GA_dut) = 0x" & to_hstring(gg_ga_dut) & LF & 
                 "(GG_GA_gm) = 0x" & to_hstring(gg_ga_gm) 
          severity failure;
       wait for DELAY_TIME;
       in_stim <= in_stim + 1;
     end loop stim_combos;
     report "@TB: " & to_string(SIZE_ONE) & "-bit multi-level CLA is fully functional";
     wait;  --suspend this process
  end process stim_gen1;

end architecture behavior;
