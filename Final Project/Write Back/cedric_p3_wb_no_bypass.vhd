library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity p3_wb_no_bypass is
	generic (SIZE : positive := 32);
	port (	RDinW : in std_logic_vector(31 downto 0);
		ALUResult2InW : in std_logic_vector(31 downto 0);
		WAInW : in std_logic_vector(4 downto 0);
		selWD : in std_logic;
		WDinD : out std_logic_vector(31 downto 0);
		WAinD : out std_logic_vector(4 downto 0)
		);
end entity p3_wb_no_bypass;

architecture structure of p3_wb_no_bypass is
begin
muxforWD : entity work.mux_2to1(mixed)
		generic map(SIZE=>SIZE)
		port map(	w0 => RDinW,
				w1 => ALUResult2InW,
				s => selWD,
				f => WDinD);
WAinD <= WAInW;


end architecture structure;