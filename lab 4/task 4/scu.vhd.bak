library ieee;
use ieee.std_logic_1164.all;

entity scu is
  port( NZVC : in std_logic_vector(3 downto 0); --Condition code flags
	arith : in std_logic;  --(Un)Signed control
        z_GSE : out std_logic_vector(2 downto 0)--Comparison results 
	); 
end entity scu;

--The subtraction comparison unit (SCU) comprises one combinational logic network that produces a 3-bit signal z_GSE_signed in
--terms of NZVC and another combinational logic network that produces a 3-bit signal
--z_GSE_unsigned in terms of NZVC. A 2-to-1 multiplexer selects z_GSE_unsigned or
--z_GSE_signed according to arith control signal. 
--
--In an architecture named mixed, use entity instantiation statements and named association to
--model multiplexer of the SCU. Additionally, use simple concurrent signal assignment statements to
--model combinational logic. Finally, utilize alias objects to separate out the three flags such that your
--source code may be made more readable.


architecture mixed of scu is

signal un_signed, signedcom : std_logic_vector(2 downto 0);
--aliases are used to identiy separately c, v, z, n that come together in 1 vector
alias c : std_logic is NZVC(0);
alias v : std_logic is NZVC(1);
alias z : std_logic is NZVC(2);
alias n : std_logic is NZVC(3);

begin

un_signed(0) <= z and c;
un_signed(1) <= not (z or c);
un_signed(2) <= (not z) and c;
signedcom(0) <= z;
signedcom(1) <= ((not z) and (not v) and n) or ((not z) and v and (not n));
signedcom(2) <= ((not z) and (not v) and (not n)) or ((not z) and v and n);

mux2_1: entity work.mux_2to1(mixed)
	generic map(SIZE => 3)
	port map(w0 => un_signed, w1=> signedcom, s => arith, f =>z_GSE);

end architecture mixed;