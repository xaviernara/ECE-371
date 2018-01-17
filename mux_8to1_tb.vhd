library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.data_types.all;

entity mux_8to1_tb is
end entity mux_8to1_tb;

architecture behavior of mux_8to1_tb is
   constant N : positive := 8;  --8 input buses
   constant M1 : positive := 1; --input bus widths for dut1
   constant M2 : positive := 2; --input bus widths for dut2
   constant DELAY_TIME : delay_length := 1 ps;   
   
   signal in_stim1 : unsigned(N*M1 + 2 downto 0) := (others => '0');
   signal data_matrix_stim1 : matrix(N-1 downto 0, M1-1 downto 0);
   signal f_dut1, f_gm1 : std_logic_vector(M1-1 downto 0);
   
   signal in_stim2 : unsigned(N*M2 + 2 downto 0) := (others => '0');
   signal data_matrix_stim2 : matrix(N-1 downto 0, M2-1 downto 0);
   signal f_dut2, f_gm2 : std_logic_vector(M2-1 downto 0);

--   alias en_stim1 : unsigned(0 downto 0) is in_stim1(N*M1+3 downto N*M1+3);
   alias s_stim1 : unsigned(2 downto 0) is in_stim1(N*M1+2 downto N*M1);
   alias w0_stim1 : unsigned(M1-1 downto 0) is in_stim1(N*M1-1 downto (N-1)*M1 );
   alias w1_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-1)*M1-1 downto (N-2)*M1);
   alias w2_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-2)*M1-1 downto (N-3)*M1);
   alias w3_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-3)*M1-1 downto (N-4)*M1);
   alias w4_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-4)*M1-1 downto (N-5)*M1 );
   alias w5_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-5)*M1-1 downto (N-6)*M1);
   alias w6_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-6)*M1-1 downto (N-7)*M1);
   alias w7_stim1 : unsigned(M1-1 downto 0) is in_stim1((N-7)*M1-1 downto (N-8)*M1);
  
--   alias en_stim2 : unsigned(0 downto 0) is in_stim2(N*M2+3 downto N*M2+3);
   alias s_stim2 : unsigned(2 downto 0) is in_stim2(N*M2+2 downto N*M2);
   alias w0_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-0)*M2-1 downto (N-1)*M2);
   alias w1_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-1)*M2-1 downto (N-2)*M2);
   alias w2_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-2)*M2-1 downto (N-3)*M2 );
   alias w3_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-3)*M2-1 downto (N-4)*M2);
   alias w4_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-4)*M2-1 downto (N-5)*M2);
   alias w5_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-5)*M2-1 downto (N-6)*M2);
   alias w6_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-6)*M2-1 downto (N-7)*M2 );
   alias w7_stim2 : unsigned(M2-1 downto 0) is in_stim2((N-7)*M2-1 downto (N-8)*M2);
begin
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for a M1-bit 8-to-1 multiplexer
  ------------------------------------------------------------------------------------------
  dut1 : entity work.mux_8to1(structure)
  generic map(SIZE => M1)
  port map (
			  --  en => en_stim1(0),
              s  => std_logic_vector(s_stim1),
              w0 => std_logic_vector(w0_stim1),
              w1 => std_logic_vector(w1_stim1),
              w2 => std_logic_vector(w2_stim1),
              w3 => std_logic_vector(w3_stim1),
              w4 => std_logic_vector(w4_stim1),
              w5 => std_logic_vector(w5_stim1),
              w6 => std_logic_vector(w6_stim1),
              w7 => std_logic_vector(w7_stim1),
              f => f_dut1 );

  busses1 : for i in 0 to N-1 generate
     dbus1 : for j in 0 to M1-1 generate
        data_matrix_stim1(i, j) <= in_stim1(i*M1+j); 
     end generate dbus1;
  end generate busses1;
  
  gm1 : entity work.mux_golden(behavior)
  generic map (M => M1, N => N)
  port map (
			  --  en => en_stim1(0),
              s => std_logic_vector(s_stim1),
              data_matrix => data_matrix_stim1,
              f => f_gm1 );
              
  ------------------------------------------------------------------------------------------
  --  Instantiate golden model and design under test (DUT) 
  --  model for a M2-bit 8-to-1 multiplexer
  ------------------------------------------------------------------------------------------
  dut2 : entity work.mux_8to1(structure)
  generic map(SIZE => M2)
  port map (  
			  --en => en_stim2(0),
              s  => std_logic_vector(s_stim2),
              w0 => std_logic_vector(w0_stim2),
              w1 => std_logic_vector(w1_stim2),
              w2 => std_logic_vector(w2_stim2),
              w3 => std_logic_vector(w3_stim2),
              w4 => std_logic_vector(w4_stim2),
              w5 => std_logic_vector(w5_stim2),
              w6 => std_logic_vector(w6_stim2),
              w7 => std_logic_vector(w7_stim2),
              f => f_dut2 );

  busses2 : for i in 0 to N-1 generate
     dbus2 : for j in 0 to M2-1 generate
        data_matrix_stim2(i, j) <= in_stim2(i*M2+j); 
     end generate dbus2;
  end generate busses2;
  
  gm2 : entity work.mux_golden(behavior)
  generic map (M => M2, N => N)
  port map (
			  --en => en_stim2(0),
              s => std_logic_vector(s_stim2),
              data_matrix => data_matrix_stim2,
              f => f_gm2 );
              
  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for M1-bit 8-to-1 multiplexer
  ------------------------------------------------------------------------------------------
  stim_gen1 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim1'length - 1 loop
        assert f_dut1 = f_gm1
           report "@TB: Output missmatch:" & LF &
              --    "(en_stim1) = " & integer'image(to_integer(unsigned(en_stim1))) & LF &
                  "(s_stim1) = " & integer'image(to_integer(unsigned(s_stim1))) & LF &
                  "(w0_stim1) = " & integer'image(to_integer(unsigned(w0_stim1))) & LF &
                  "(w1_stim1) = " & integer'image(to_integer(unsigned(w1_stim1))) & LF &
                  "(w2_stim1) = " & integer'image(to_integer(unsigned(w2_stim1))) & LF &
                  "(w3_stim1) = " & integer'image(to_integer(unsigned(w3_stim1))) & LF &
                  "(w4_stim1) = " & integer'image(to_integer(unsigned(w4_stim1))) & LF &
                  "(w5_stim1) = " & integer'image(to_integer(unsigned(w5_stim1))) & LF &
                  "(w6_stim1) = " & integer'image(to_integer(unsigned(w6_stim1))) & LF &
                  "(w7_stim1) = " & integer'image(to_integer(unsigned(w7_stim1))) & LF &
                  "(f_dut1) = " & integer'image(to_integer(unsigned(f_dut1))) & LF &
                  "(f_gm1) = " & integer'image(to_integer(unsigned(f_gm1)))
           severity failure;
        wait for DELAY_TIME;
        in_stim1 <= in_stim1 + 1;
     end loop stim_combos;
     report "@TB: " & integer'image(M1) & "-bit " & integer'image(N) & "-to-1 multiplexer is fully functional";
     wait;  --suspend this process
  end process stim_gen1;

  ------------------------------------------------------------------------------------------
  --  Stimulus generation for golden and design-under-test (DUT)
  --  model for M2-bit 8-to-1 multiplexer
  ------------------------------------------------------------------------------------------
  stim_gen2 : process is 
  begin
     stim_combos : for i in 0 to 2**in_stim2'length - 1 loop
        assert f_dut2 = f_gm2
           report "@TB: Output missmatch:" & LF &
               -- "(en_stim2) = " & integer'image(to_integer(unsigned(en_stim2))) & LF &
                  "(s_stim2) = " & integer'image(to_integer(unsigned(s_stim2))) & LF &
                  "(w0_stim2) = " & integer'image(to_integer(unsigned(w0_stim2))) & LF &
                  "(w1_stim2) = " & integer'image(to_integer(unsigned(w1_stim2))) & LF &
                  "(w2_stim2) = " & integer'image(to_integer(unsigned(w2_stim2))) & LF &
                  "(w3_stim2) = " & integer'image(to_integer(unsigned(w3_stim2))) & LF &
                  "(w4_stim2) = " & integer'image(to_integer(unsigned(w4_stim2))) & LF &
                  "(w5_stim2) = " & integer'image(to_integer(unsigned(w5_stim2))) & LF &
                  "(w6_stim2) = " & integer'image(to_integer(unsigned(w6_stim2))) & LF &
                  "(w7_stim2) = " & integer'image(to_integer(unsigned(w7_stim2))) & LF &
                  "(f_dut2) = " & integer'image(to_integer(unsigned(f_dut2))) & LF &
                  "(f_gm2) = " & integer'image(to_integer(unsigned(f_gm2)))
           severity failure;
        wait for DELAY_TIME;
        in_stim2 <= in_stim2 + 1;
     end loop stim_combos;
     report "@TB: " & integer'image(M2) & "-bit " & integer'image(N) & "-to-1 multiplexer is fully functional";
     wait;  --suspend this process
  end process stim_gen2;
end architecture behavior;
