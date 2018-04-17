library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p3_fetch_no_bypass is
	generic (SIZE : positive := 32;
		 I5SIZE : positive := 5;
 		 I8SIZE : positive := 8;
 		 I16SIZE : positive := 16;
		 OSIZE : positive := 32;
		 R0_HW : boolean := true;
		 BYPASS : boolean := FALSE);
--Comes from Controller
	port (	Branch_Mux_Control_RTGSED: in std_logic_vector(1 downto 0);
		clk,rst : IN std_logic;
		BTA_INF : IN std_logic_vector(31 downto 0);
		JRTA_INF : IN std_logic_vector(31 downto 0);
		JTA_INF : IN std_logic_vector(31 downto 0);
		rd1ineinD : out std_logic_vector(31 downto 0);
		PC1inD : out std_logic_vector(31 downto 0)
		);
end entity p3_fetch_no_bypass;

architecture structure of p3_fetch_no_bypass is
	
	signal INST_ADD: std_logic_vector(31 downto 0);
	signal rd1ineoutF : std_logic_vector(31 downto 0);
	signal PC1outF : std_logic_vector(31 downto 0);
	signal  INST_ADD_OUT : std_logic_vector(31 downto 0);
	signal PC_Plus1 : std_logic_vector(31 downto 0);

begin 
	

--PC + 1

        PC_Plus1 <= INST_ADD_OUT or 32x"1";
	PC1outF <= PC_Plus1;
        
       INSMEM : entity work.instructionROM(behavior)
		generic map(SIZE => SIZE )
		port map(	aclr => '0', 
				address => INST_ADD(7 downto 0) ,
				clken => '1' ,
				clock => clk,    
				q => rd1ineoutF );


	selADDRESS : entity work.mux_4to1(behavior)
		generic map(SIZE => SIZE )
		port map(	w0 => PC_Plus1 , 
				w1 => JRTA_INF ,
				w2 => BTA_INF ,
				w3 => JTA_INF,    
				s => Branch_Mux_Control_RTGSED,
				f => INST_ADD);

	
	
	

-- Through the pipeline

	dflopforPC1 : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => PC1outF,
					q => PC1inD);

	dflopforRD : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => rd1ineoutF ,
					q => rd1ineinD);

	dflopBEFOREPC1: entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din =>  INST_ADD,
					q => INST_ADD_OUT );


end architecture structure;
