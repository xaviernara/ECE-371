-- half_adder.vhdl
-- desc: 1bit half adder from scratch

entity HALF_ADDER is
  port(A,   B:     in  bit;
       SUM, CARRY: out bit);
end HALF_ADDER;

architecture DATAFLOW of HALF_ADDER is
begin
    SUM   <= A xor B;
    CARRY <= A and B;
end DATAFLOW;
