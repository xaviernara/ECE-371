library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Decoder is
	generic (SIZE : positive := 32;
		 I5SIZE : positive := 5;
 		 I8SIZE : positive := 8;
 		 I16SIZE : positive := 16;
		 OSIZE : positive := 32;
		 R0_HW : boolean := true;
		 BYPASS : boolean := true);
	port (	INSinD : in std_logic_vector(31 downto 0);
		PC_1inD : in std_logic_vector(31 downto 0);
		WAinD : in std_logic_vector(4 downto 0);
		WDinD : in std_logic_vector(31 downto 0);
		wren,clk,rst : in std_logic;
		selEXT : in std_logic;
		selWA : in std_logic_vector(1 downto 0);
		selBZ : in std_logic;
		


		rd1inE,rd2inE : out std_logic_vector(31 downto 0);
		GSEoutD : out std_logic_vector(2 downto 0);
		BTAoutD : out std_logic_vector(7 downto 0);
		JRoutD : out std_logic_vector(7 downto 0);
		JoutD : out std_logic_vector(7 downto 0);
		PC1EXT32inE : out std_logic_vector(31 downto 0);
		IMMEXT32inE : out std_logic_vector(31 downto 0);
		SHAMTinE : out std_logic_vector(31 downto 0);
		WAinE : out std_logic_vector(4 downto 0);
		ops : out std_logic_vector(5 downto 0);
		funct : out std_logic_vector(5 downto 0);
		rtforCU : out std_logic_vector(4 downto 0)
		);
end entity Decoder;

architecture structure of Decoder is
signal rs,rt,rd : std_logic_vector(4 downto 0);
signal shamt : std_logic_vector(4 downto 0);
signal imm8 : std_logic_vector(7 downto 0);
signal imm16 : std_logic_vector(15 downto 0);
signal R31 : std_logic_vector(4 downto 0);
signal PC8 : std_logic_vector(7 downto 0);
signal zero : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal BZ : std_logic_vector(31 downto 0);
signal rd1outD,rd2outD : std_logic_vector(31 downto 0);
signal SHAMToutD : std_logic_vector(31 downto 0);
signal PC1EXT32outD : std_logic_vector(31 downto 0);
signal IMMEXT32outD : std_logic_vector(31 downto 0);
signal WAoutD : std_logic_vector(4 downto 0);

begin 
	ops <= INSinD(31 downto 26);
	funct <= INSinD(5 downto 0);
	rs <= INSinD(25 downto 21);
	rt <= INSinD(20 downto 16);
	rd <= INSinD(15 downto 11);
	shamt <= INSinD(10 downto 6);
	imm8 <= INSinD(7 downto 0);
	imm16 <= INSinD(15 downto 0);

	R31 <= "11111";
	
	PC8 <= PC_1inD(7 downto 0);

	JoutD <= imm8;
	JRoutD <= rd1outD(7 downto 0);


	ARF : entity work.arf32_config(structure)
		generic map(SIZE=>SIZE,R0_HW=>R0_HW,BYPASS=>BYPASS)
		port map(	clk => clk,
				rst => rst,
				rdAddr1 => rs,
				rdAddr2 => rd,
				wrAddr => WAinD,
				wren => wren,
				wrData => WDinD,
				rdData1 => rd1outD,
				rdData2 => rd2outD);

	ZEXTforSHAMT : entity work.elu(dataflow)
		generic map(ISIZE=>I5SIZE,OSIZE=>OSIZE)
		port map(	A => shamt, 
				twos_cmp => '0',
				Y => SHAMToutD);
	
	ZEXTforPC1 : entity work.elu(dataflow)
		generic map(ISIZE=>I8SIZE,OSIZE=>OSIZE)
		port map(	A => PC8, 
				twos_cmp => '0',
				Y => PC1EXT32outD);

	EXTforIMM : entity work.elu(dataflow)
		generic map(ISIZE=>I16SIZE,OSIZE=>OSIZE)
		port map(	A => imm16, 
				twos_cmp => selEXT,
				Y => IMMEXT32outD);

	selWriteAddress : entity work.mux_4to1(behavior)
		generic map(SIZE => I5SIZE )
		port map(	w0 => rd, 
				w1 => rt,
				w2 => R31,
				w3 => R31,    --I DONT KNOW HOW TO FIX IT, IT SHOULD BE ZERO
				s => selWA,
				f => WAoutD);

	CLA : entity work.cla_8bit(structure)
		port map(	x => imm8,
				y => PC8,
				cin => '0',
				sum =>BTAoutD,
				GG =>OPEN,
				GA =>OPEN );

	
	selBranchwithZero : entity work.mux_2to1(mixed)
		generic map(SIZE => SIZE)
		port map(	w0 => rd2outD,
				w1 => zero,
				s => selBZ,
				f => BZ);

	BTC : entity work.btc_32bit(structure)
		generic map(SIGNED_OPS => true)
		port map(	x => rd1outD,
				Y => rd2outD,
				z_GSE => GSEoutD);


-- Through the pipeline

	dflopforshamt : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => SHAMToutD,
					q => SHAMTinE);

	dflopforRD1 : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => rd1outD,
					q => rd1inE);

	dflopforRD2 : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => rd2outD,
					q => rd2inE);

	dflopforPC1 : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => PC1EXT32outD,
					q => PC1EXT32inE);

	dflopforIMM : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => IMMEXT32outD,
					q => IMMEXT32inE);

	dflopforWA : entity work.dflop(behavior)
			generic map(SIZE=>SIZE)
			port map(	clk => clk,
					rst => rst,
					clken => '1',
					din => WAoutD,
					q => WAinE);

	



end architecture structure;
