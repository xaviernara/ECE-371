library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arf8 is
generic(SIZE : positive := 4;
	R0_HW : boolean := true);
port(	clk, rst, wrEn : in std_logic;
	rdAddr1, rdAddr2, wrAddr : in std_logic_vector(2 downto 0);
	wrData : in std_logic_vector(SIZE - 1 downto 0);
	rdData1, rdData2 : out std_logic_vector(SIZE -1 downto 0));
end arf8;

architecture structure of arf8 is
signal clkEn : std_logic_vector(7 downto 0);
type q_type is array(0 to 8) of
	std_logic_vector(SIZE - 1 downto 0);
signal q : q_type;

begin
notHardWired: if not R0_HW generate
	flopsBlock: for i in 0 to 7 generate
	dFlop: entity work.dflop(behavior)
		generic map(SIZE)
		port map(clk, rst, clkEn(i), wrData, q(i));
	end generate;
end generate;
HardWired: if R0_HW generate
	flopsBlock: for i in 1 to 7 generate
	dFlop: entity work.dflop(behavior)
		generic map(SIZE)
		port map(clk, rst, clkEn(i), wrData, q(i));
	end generate;
	q(0) <= (others => '0');
end generate;
WriteAddressBlock: entity work.dec_3to8(behavior)
	port map(wrAddr, wrEn, clkEn);

Read1AddressBlock: entity work.mux_8to1(behavior)
	generic map(SIZE)
	port map(q(0), q(1), q(2), q(3),
 		 q(4), q(5), q(6), q(7),
		 rdAddr1, rdData1);

Read2AddressBlock: entity work.mux_8to1(behavior)
	generic map(SIZE)
	port map(q(0), q(1), q(2), q(3),
 		 q(4), q(5), q(6), q(7),
		 rdAddr2, rdData2);
end structure;