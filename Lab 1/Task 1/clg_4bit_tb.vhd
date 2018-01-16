library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clg_4bit_tb is
end entity clg_4bit_tb;

architecture behavior of clg_4bit_tb is
   constant IN_SIZE : positive := 4;
   constant DELAY_TIME : delay_length := 1 ps;
   
   signal in_stim : unsigned(2*IN_SIZE downto 0) := (others => '0');
   signal c_dut, c_gm : std_logic_vector(IN_SIZE downto 1);
-- signal GG_dut, GP_dut, GG_gm, GP_gm : std_logic_vector(0 downto 0);
   signal GG_dut, GA_dut, GG_gm, GA_gm : std_logic_vector(0 downto 0);
   alias c0_stim : std_logic is in_stim(2*IN_SIZE);
   alias g_stim: unsigned(IN_SIZE-1 downto 0) is in_stim(2*IN_SIZE-1 downto IN_SIZE);
-- alias p_stim: unsigned(IN_SIZE-1 downto 0) is in_stim(IN_SIZE-1 downto 0);
   alias a_stim: unsigned(IN_SIZE-1 downto 0) is in_stim(IN_SIZE-1 downto 0);
begin
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  ------------------------------------------------------------------------------------------
  gm : entity work.clg_golden(behavior)
  generic map( SIZE => IN_SIZE )
  port map (  c0 => c0_stim,
              g => std_logic_vector(g_stim),
              p => std_logic_vector(a_stim),
              c => c_gm,
              GG => GG_gm(0),
              GP => GA_gm(0));

  dut : entity work.clg_4bit(dataflow)
  port map (  c0 => c0_stim,
              g => std_logic_vector(g_stim),
              a => std_logic_vector(a_stim),
              c => c_dut,
              GG => GG_dut(0),
              GA => GA_dut(0) );  

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  ------------------------------------------------------------------------------------------
  stim_gen : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim'length - 1 loop
        assert c_dut = c_gm
           report "E@TB: Output missmatch:" & LF &
                  "(c_dut) = " & integer'image(to_integer(unsigned(c_dut))) & LF &
                  "(c_gm) = " & integer'image(to_integer(unsigned(c_gm)))
           severity failure;
        assert GG_dut = GG_gm
           report "E@TB: Output missmatch:" & LF &
                  "(GG_dut) = " & integer'image(to_integer(unsigned(GG_dut))) & LF &
                  "(GG_gm) = " & integer'image(to_integer(unsigned(GG_gm)))
           severity failure;
        assert GA_dut = GA_gm
           report "E@TB: Output missmatch:" & LF &
                  "(GA_dut) = " & integer'image(to_integer(unsigned(GA_dut))) & LF &
                  "(GA_gm) = " & integer'image(to_integer(unsigned(GA_gm)))
           severity failure;
        wait for DELAY_TIME;
        in_stim <= in_stim + 1;
     end loop stim_combos;
     report "@TB: The CLG_4bit is fully functional";
     wait;  --suspend this process
  end process stim_gen;
end architecture behavior;
