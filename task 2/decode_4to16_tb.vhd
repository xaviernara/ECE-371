library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode_4to16_tb is
end entity decode_4to16_tb;

architecture behavior of decode_4to16_tb is
   constant DECODE_IN_SIZE : positive := 4;
   constant DECODE_OUT_SIZE : positive := 2**DECODE_IN_SIZE;
   constant IN_SIZE : positive := DECODE_IN_SIZE+1;
   constant DELAY_TIME : delay_length := 1 ns;   
   
   signal in_stim : unsigned(IN_SIZE-1 downto 0) := (others => '0');
   signal y_dut, y_gm : std_logic_vector(DECODE_OUT_SIZE-1 downto 0);
   
   alias en_stim : unsigned(0 downto 0) is in_stim(IN_SIZE-1 downto IN_SIZE-1);
   alias w_stim : unsigned(IN_SIZE-2 downto 0) is in_stim(IN_SIZE-2 downto 0);
begin
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for the 4-to-16 binary decoder
  ------------------------------------------------------------------------------------------
  dut : entity work.decode_4to16(mixed)
  port map (  en => en_stim(0),
              w => std_logic_vector(w_stim),
              y => y_dut );

  gm : entity work.decoder_golden(behavior)
  generic map (SIZE => IN_SIZE-1)
  port map (  en => en_stim(0),
              w => std_logic_vector(w_stim),
              y => y_gm );
              
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for 4-to-16 binary decoder
  ------------------------------------------------------------------------------------------
  stim_gen : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim'length - 1 loop
        assert y_dut = y_gm
           report "E@TB: Output missmatch:" & LF &
                  "(en_stim) = " & integer'image(to_integer(en_stim)) & LF &
                  "(w_stim) = " & integer'image(to_integer(w_stim)) & LF &
                  "(y_dut) = " & integer'image(to_integer(unsigned(y_dut))) & LF &
                  "(y_gm) = " & integer'image(to_integer(unsigned(y_gm)))
           severity failure;
        wait for DELAY_TIME;
        in_stim <= in_stim + 1;
     end loop stim_combos;
     report "@TB: " & integer'image(DECODE_IN_SIZE) & "-to-" & integer'image(DECODE_OUT_SIZE) & " binary decoder is fully functional";
     wait;  --suspend this process
  end process stim_gen;
end architecture behavior;
