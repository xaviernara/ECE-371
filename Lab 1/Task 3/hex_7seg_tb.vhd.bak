library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex_7seg_tb is
end entity hex_7seg_tb;

architecture behavior of hex_7seg_tb is
   constant IN_SIZE : positive := 5;
   constant OUT_SIZE : positive := 7;
   constant DELAY_TIME : delay_length := 1 ps;
   
   signal in_stim : unsigned(IN_SIZE-1 downto 0) := (others => '0');
   signal led_segs_dut : std_logic_vector(OUT_SIZE-1 downto 0) := (others => '0');
   signal led_segs_gm : std_logic_vector(OUT_SIZE-1 downto 0):= (others => '0');
   alias en_stim : unsigned(0 downto 0) is in_stim(IN_SIZE-1 downto IN_SIZE-1);
   alias hex_val_stim : unsigned(IN_SIZE-2 downto 0) is in_stim(IN_SIZE-2 downto 0);   
begin
  
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design model
  ------------------------------------------------------------------------------------------
  gm : entity work.hex_7seg_golden(behavior)
  port map (  en => en_stim(0),
              hex_val => std_logic_vector(hex_val_stim),
              seg_lights => led_segs_gm );

  dut : entity work.hex_7seg(behavior)
  port map (  en => en_stim(0),
              hex_val => std_logic_vector(hex_val_stim),
              seg_lights => led_segs_dut );  

  ------------------------------------------------------------------------------------------
  --  Stimulus generation and self-checking for golden and design model
  ------------------------------------------------------------------------------------------
  stim_gen : process is begin
     wait for DELAY_TIME;
     stim_combos : for i in 0 to 2**in_stim'length - 1 loop
        assert led_segs_dut = led_segs_gm
           report "E@TB: Output missmatch:" & LF &
                  "(en_stim) = "  & integer'image(to_integer(en_stim)) & LF &
                  "hex_val_stim = " & integer'image(to_integer(hex_val_stim)) & LF &
                  "led_segs_dut = " & integer'image(to_integer(unsigned(led_segs_dut))) & LF &
                  "led_segs_gm = " &  integer'image(to_integer(unsigned(led_segs_gm)))
           severity failure;
        wait for DELAY_TIME;
        in_stim <= in_stim + 1;
     end loop stim_combos;
     report "@TB: Hexadecimal-to-7-Segment Decoder/Driver is fully functional";
     wait;  --suspend this process
  end process stim_gen;
end architecture behavior;
