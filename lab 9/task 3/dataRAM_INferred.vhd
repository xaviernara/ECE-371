library ieee;
use ieee.std_logic_1164.all;

entity dataRAM_INferred is

	generic 
	(
		ASIZE : positive := 5;
		DSIZE : natural := 4 );

	port (
		clock	: in std_logic;
		wrEN  : in std_logic;
		addr	: in std_logic_vector(ASIZE-1 Downto 0);
		din	: in std_logic_vector(DSIZE-1 Downto 0);
		qout	: out std_logic_vector(DSIZE-1 Downto 0)
	);

end entity dataRAM_INferred;

architecture BEHAVIOR of dataRAM_INferred is

	-- Build a 2-D array type for the RAM
	type memory is array(ASIZE-1 downto 0) of std_logic_vector(DSIZE-1 Downto 0);

	-- Declare the RAM signal.	
	signal RAMArray : memory;
	--signal signal_ClkEn : std_logic_vector(7 Downto 0);
	--signal signal_dec2to4 : std_logic_vector(3 Downto 0);
	

begin

	process(clock) 
	begin
	
		if(clock'event and clock = '1') then
		
			for index in 0 to ASIZE -1 loop
			
				  if (wrEN= '1') THEN
				--if (wrEN= '1') THEN
					RAMArray(index) <= din;
				end if;
				
				qout <= RAMArray(index);

			end loop;
			
		end if;	
	end process;


end architecture BEHAVIOR;
