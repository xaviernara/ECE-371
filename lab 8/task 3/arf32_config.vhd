library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arf32_config is
generic(SIZE : positive := 6;
	R0_HW : boolean := true;
	BYPASS : boolean := true);
port(	clk, rst, wrEn : in std_logic;
	rdAddr1, rdAddr2, wrAddr : in std_logic_vector(4 downto 0);
	wrData : in std_logic_vector(SIZE - 1 downto 0);
	rdData1, rdData2 : out std_logic_vector(SIZE -1 downto 0));
end arf32_config;

architecture mixed of arf32_config is
signal rdReg1, rdReg2 : std_logic_vector(SIZE - 1 downto 0);

begin
Bypass_R0_HW: if R0_HW and BYPASS generate
	BypassAndHW: entity work.arf32(structure)
	generic map(SIZE, R0_HW)
	port map(clk, rst, wrEn, rdAddr1, rdAddr2,
		 wrAddr, wrData, rdReg1, rdReg2);
	rdData1 <= 	wrData when wrEn = '1' and wrAddr /= "00000" else
					(others => '0')when wrAddr = "00000" else
					rdReg1;
	rdData2 <= 	wrData when wrEn = '1' and wrAddr /= "00000" else
					(others => '0')when wrAddr = "00000" else
					rdReg2;
	elsif not R0_HW and Bypass generate
	BypassAndNoHW: entity work.arf32(structure)
	generic map(SIZE, R0_HW)
	port map(clk, rst, wrEn, rdAddr1, rdAddr2,
		 wrAddr, wrData, rdReg1, rdReg2);
	rdData1 <= 	wrData when wrEn = '1' else
					rdReg1;
	rdData2 <= 	wrData when wrEn = '1' else
					rdReg2;
	else generate
	BypassAndNoHW: entity work.arf32(structure)
	generic map(SIZE, R0_HW)
	port map(clk, rst, wrEn, rdAddr1, rdAddr2,
		 wrAddr, wrData, rdData1, rdData2);
	end generate;

end mixed;