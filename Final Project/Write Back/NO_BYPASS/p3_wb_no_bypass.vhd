library ieee;
use ieee.std_logic_1164.all;

entity p3_wb_no_bypass is
	generic (SIZE : positive := 32);
	port (	ReadData_MEMORY_input : in std_logic_vector(31 downto 0);
		ALUWriteAddress_EXECUTE_input : in std_logic_vector(31 downto 0);
		WriteAddress_In_DECODE : in std_logic_vector(4 downto 0);
		IsLoadData_WB_SELECT : in std_logic;
		WriteData_WB_in_DECODE : out std_logic_vector(31 downto 0);
		WriteAddress_WB_in_DECODE : out std_logic_vector(4 downto 0)

--		WriteData_WB_output: out std_logic_vector(4 downto 0);
--		WriteAddress_OUTPUT : out std_logic_vector(31 downto 0)
		);
end entity p3_wb_no_bypass;

architecture structure of p3_wb_no_bypass is
begin

MUX_for_WB : entity work.mux_2to1(mixed)
generic map(SIZE=>SIZE)
port map(w0 => ReadData_MEMORY_input,w1 => ALUWriteAddress_EXECUTE_input,s => IsLoadData_WB_SELECT,f => WriteData_WB_output);

WriteAddress_WB_in_DECODE <= WriteAddress_In_DECODE;


end architecture structure;
