
library ieee;
use ieee.std_logic_1164.all;

entity log_bsru is
generic (CNT_SIZE : positive := 4);
  port (A 		: in std_logic_vector(2**CNT_SIZE-1 downto 0);
	cnt 		: in std_logic_vector(CNT_SIZE-1 downto 0);
	shift, right, arith  : in std_logic;
	f		: out std_logic_vector(2**CNT_SIZE-1 downto 0)
    );
end entity log_bsru;

architecture structure of log_bsru is

type FSRUOut_Type is array(0 to CNT_SIZE) of std_logic_vector(2**CNT_SIZE-1 downto 0);
signal fsru_outs : FSRUOut_Type;
signal srin : std_logic;
 
begin

first_reverse: entity work.bru(behavior)
	generic map(2**CNT_SIZE)
	port map(A, right, fsru_outs(0));

srin <= arith and a(2**CNT_SIZE-1) and right;
intermediate : for i in 0 to CNT_SIZE-1 generate
	
shift_rot: entity work.right_fsru(mixed)
	generic map(2**CNT_SIZE, 2**(i))
	port map(fsru_outs(i), cnt(i), shift, srin, fsru_outs(i+1));
	end generate;

second_reverse: entity work.bru(behavior)
	generic map(2**CNT_SIZE)
	port map(fsru_outs(CNT_SIZE), right, f);

end architecture structure;

