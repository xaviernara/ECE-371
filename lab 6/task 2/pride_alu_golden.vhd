 mlibrary ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pride_alu_golden is
  generic(LOG2_SIZE : positive := 2 );
  port( x, y    : in std_logic_vector(2**LOG2_SIZE-1 downto 0);
        funct   : in std_logic_vector(3 downto 0);
        r       : out std_logic_vector(2**LOG2_SIZE-1 downto 0);
        NZVC    : out std_logic_vector(3 downto 0) );
end entity pride_alu_golden;

architecture golden of pride_alu_golden is
  constant SIZE : positive := 2**LOG2_SIZE;
  constant FUNCT_SIZE : positive := 4;
  constant ALL_ZEROS : signed(SIZE-1 downto 0) := (others => '0');
  constant FUNCT_AND : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"0";
  constant FUNCT_OR : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"1";
  constant FUNCT_XOR : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"2";
  constant FUNCT_NOR : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"3";
  constant FUNCT_ADDU : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"4";
  constant FUNCT_ADD : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"5";
  constant FUNCT_SUBU : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"6";
  constant FUNCT_SUB : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"7";
  constant FUNCT_SLTU : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"A";
  constant FUNCT_SLT : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"B";
  constant FUNCT_SLL : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"C";
  constant FUNCT_SRL : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"E";
  constant FUNCT_SRA : std_logic_vector(FUNCT_SIZE-1 downto 0) := 4x"F"; 
  signal x_s, y_s : signed(SIZE-1 downto 0);
  signal r_s : signed(SIZE downto 0);
  signal Vflag_add, Vflag_sub : std_logic;
  alias carry_bit : std_logic is r_s(SIZE);
  alias r_result : signed(SIZE-1 downto 0) is r_s(SIZE - 1 downto 0);
  alias x_msb : signed(0 downto 0) is x_s(SIZE-1 downto SIZE-1);
  alias y_msb : signed(0 downto 0) is y_s(SIZE-1 downto SIZE-1);
  alias r_msb : signed(0 downto 0) is r_s(SIZE-1 downto SIZE-1);
begin
	x_s <= signed(x);
	y_s <= signed(y);
	r <= std_logic_vector(r_result);
	alu : process(x_s, y_s, funct) is begin
       carry_bit <= '0'; --default value
       alu_sel : case funct is
	        when FUNCT_AND => 
			   r_result <= x_s and y_s;
		    when FUNCT_OR  => 
			   r_result <= x_s or y_s;
		    when FUNCT_XOR =>
			   r_result <= x_s xor y_s;
		    when FUNCT_NOR => 
			   r_result <= x_s nor y_s;
			when FUNCT_ADDU => 
			   r_s <= ('0' & x_s) + ('0' & y_s);
   			when FUNCT_ADD => 
			   r_result <= x_s + y_s;
		    when FUNCT_SUBU =>
			   r_s <= ('0' & x_s) - ('1' & y_s);
   		    when FUNCT_SUB =>
			   r_result <= x_s - y_s;
		    when FUNCT_SLTU => 
			   if ( unsigned(x_s) < unsigned(y_s) ) then 
			      r_result <= ALL_ZEROS(SIZE-1 downto 1) & '1';
			   else
			      r_result <= ALL_ZEROS;
			   end if;
		    when FUNCT_SLT => 
			   if (x_s < y_s) then 
			      r_result <= ALL_ZEROS(SIZE-1 downto 1) & '1';
			   else
			      r_result <= ALL_ZEROS;
			   end if;
		    when FUNCT_SRL =>
			   r_result <= signed( shift_right( unsigned(y_s), 
  			                       to_integer(unsigned(x_s(LOG2_SIZE-1 downto 0)))) 
					             );
		    when FUNCT_SRA =>
  			   r_result <= shift_right( y_s, 
				                        to_integer(unsigned(x_s(LOG2_SIZE-1 downto 0))) 
						              );
		    when FUNCT_SLL => 
  			   r_result <= signed( shift_left( unsigned(y_s), 
			                       to_integer(unsigned(x_s(LOG2_SIZE-1 downto 0)))) 
					             );
		    when others => 
			   r_s <= (others => '-');
	      end case alu_sel;
	end process alu; 
	
	---------------------------------------------------
	-- Flag logic
	---------------------------------------------------
	Vflag_add <= (x_msb(0) and y_msb(0) and not(r_msb(0))) or ((x_msb(0) nor y_msb(0)) and r_msb(0));
	Vflag_sub <= (x_msb(0) and (y_msb(0) nor r_msb(0))) or (not(x_msb(0)) and y_msb(0) and r_msb(0));

	NZVC(2) <= '1' when r_result = ALL_ZEROS else '0';
	with funct select
		NZVC(3) <= r_msb(0) when FUNCT_ADD | FUNCT_SUB,
			            '0' when others;
	with funct select
		NZVC(0) <= carry_bit when FUNCT_ADDU | FUNCT_SUBU,
			             '0' when others;
	with funct select
		NZVC(1) <= Vflag_add when FUNCT_ADD, 
			       Vflag_sub when FUNCT_SUB,
			             '0' when others;	
end architecture golden;
