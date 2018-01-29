library ieee;
use ieee.std_logic_1164.all;

package data_types is
  type matrix is array( natural range <>, natural range <> ) of std_logic;
end package data_types;
