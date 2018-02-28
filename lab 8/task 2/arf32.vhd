library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arf32 is
generic(SIZE : positive := 6;
	R0_HW : boolean := true);
port(	clk, rst, wrEn : in std_logic;
	rdAddr1, rdAddr2, wrAddr : in std_logic_vector(4 downto 0);
	wrData : in std_logic_vector(SIZE - 1 downto 0);
	rdData1, rdData2 : out std_logic_vector(SIZE -1 downto 0));
end arf32;

architecture structure of arf32 is
signal wr : std_logic_vector(7 downto 0);
type rd_type is array(0 to 3) of
	std_logic_vector(SIZE - 1 downto 0);
signal rd1, rd2 : rd_type;
begin
writingBlock: entity work.dec_3to8(behavior)
	port map("0" & wrAddr(4 downto 3), wrEn, wr);

arf_0to7: entity work.arf8(structure)
	generic map(SIZE, R0_HW)
	port map(clk, rst, wr(0), rdAddr1(2 downto 0), rdAddr2(2 downto 0), wrAddr(2 downto 0),wrData, rd1(0), rd2(0));
arf_8to15: entity work.arf8(structure)
	generic map(SIZE, false)
	port map(clk, rst, wr(1), rdAddr1(2 downto 0),rdAddr2(2 downto 0), wrAddr(2 downto 0),wrData, rd1(1), rd2(1));
	
arf_16to23: entity work.arf8(structure)
	generic map(SIZE, false)
	port map(clk, rst, wr(2), rdAddr1(2 downto 0),rdAddr2(2 downto 0), wrAddr(2 downto 0),wrData, rd1(2), rd2(2));
	
arf_24to31: entity work.arf8(structure)
	generic map(SIZE, false)
	port map(clk, rst, wr(3), rdAddr1(2 downto 0),rdAddr2(2 downto 0), wrAddr(2 downto 0),wrData, rd1(3), rd2(3));

read1DataBlock: entity work.mux_8to1(behavior)
	generic map (SIZE)
	port map(rd1(0), rd1(1), rd1(2), rd1(3),rd1(0), rd1(1), rd1(2), rd1(3),"0" & rdAddr1(4 downto 3), rdData1);
	
read2DataBlock: entity work.mux_8to1(behavior)
	generic map (SIZE)
	port map(rd2(0), rd2(1), rd2(2), rd2(3), rd2(0), rd2(1), rd2(2), rd2(3),"0" & rdAddr2(4 downto 3), rdData2);
end architecture structure;