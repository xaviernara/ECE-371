library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_tb is 
end entity mux2to1_tb;

architecture behavior of mux2to1_tb is 
  signal in_stim : std_logic_vector (2 downto 0);
  alias s_dut : std_logic is in_stim(2); --alias makes a new name for signals 
  alias w0_dut : std_logic is in_stim(1);
  alias w1_dut : std_logic is in_stim(0);
  signal f_dut : std_logic;
  signal f_gm : std_logic;
begin
 --design under test (DUT)
	dut : work.mux2to1(dataflow)
	port map (s=>s_dut , w0=>w0_dut, w1=>w1_dut, f=>f_dut ); 

 --stimulus generation 
   stim_gen : process is
   begin
	in_stim <= "000";
     wait for 5 ps;
	in_stim <= "001";
     wait for 5 ps;
	in_stim <= "010";
     wait for 5 ps;
	in_stim <= "011";
     wait for 5 ps;
	in_stim <= "100";
     wait for 5 ps;
	in_stim <= "101";
     wait for 5 ps;
	in_stim <= "111";
     wait for 5 ps;
	in_stim <= "110";
    wait; --stop the stim generation
  end process stim_gen;

--design the golden model
 f_gm <= w0_dut when s_dut = '0' else w1_dut;
END architecture behavior;