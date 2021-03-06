library ieee;
use ieee.std_logic_1164.all;

ENTITY P3_CORE_NO_BYPASS IS 
	generic (SIZE : positive :=32;
		 I5SIZE : positive := 5;
 		 I8SIZE : positive := 8;
 		 I16SIZE : positive := 16;
		 OSIZE : positive := 32;
		 R0_HW : boolean := true;
		 BYPASS : boolean := true);
	PORT(CLK,RST,WREN : IN STD_LOGIC);

END ENTITY P3_CORE_NO_BYPASS;

architecture structure of p3_core_no_bypass IS

--INSTRUCTION FETCH STAGE INTEMEDIATE SIGNALS--
	--OUTPUT
	SIGNAL RD_OUTF:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_OUTF:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MUX_PCSEL:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL BTA_INST:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL JTRA_INST:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL JTA_INST:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DATA : std_logic_vector(31 downto 0);

----------------------------------------------------------------------------
--DECODE STAGE--
	--INPUTS
	SIGNAL WAOUTD:STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL WB_MUX_WD:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL WB_WA_WD:STD_LOGIC_VECTOR(4 DOWNTO 0);

	
	--OUTPUT
	SIGNAL RD1_OUTD:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RD2_OUTD:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC1_OUTD:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL IMM_OUTD:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SHAMT_OUTD:STD_LOGIC_VECTOR(31 DOWNTO 0);
	--INSTURCTION
	SIGNAL WE_CONTROL: STD_LOGIC;
	SIGNAL SELBZ_CONTROL: STD_LOGIC;
	SIGNAL REG_CONTROL: STD_LOGIC_VECTOR(1 DOWNTO 0);

	SIGNAL CON_GSE: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL CON_OPS:STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL CON_FUNT:STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL CON_RTCU:STD_LOGIC_VECTOR(4 DOWNTO 0);

----------------------------------------------------------------------------
--EXECUTE STAGE--
	--INPUT
	--OUTPUT
	SIGNAL RD_OUTE:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ALUOUT1E:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ALUOUT2E:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL WAOUTE:STD_LOGIC_VECTOR(4 DOWNTO 0);
	--INSTURCTION

----------------------------------------------------------------------------
--MEMORY STAGE--
	--INPUT
	--OUTPUT
	SIGNAL RDOUTM:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ALUREM:STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL WAOUTM:STD_LOGIC_VECTOR(4 DOWNTO 0);
	--INSTURCTION

----------------------------------------------------------------------------
--WRITEBACK STAGE--
	--INPUT
	--OUTPUT
	SIGNAL WAWB: STD_LOGIC_VECTOR(4 DOWNTO 0);
	--INSTURCTION

----------------------------------------------------------------------------
--CONTROLLER--
	--OUTPUT
	SIGNAL CON_EXEC_PIPE:STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL CON_MEM_PIPE:STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL CON_WB_PIPE:STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL CON_DECODE_PIPE:STD_LOGIC_VECTOR(16 DOWNTO 0);

BEGIN


	Fetch_PIPE : entity work.p3_fetch_no_bypass(structure)
		port map(       Branch_Mux_Control_RT_GSED => MUX_PCSEL,
				clk => clk,
				rst => rst,
				wren=> WREN,
				--wren=> '1',
				--'1'=>WREN,
				BTA_IN_FETCH  => BTA_INST,
				--BTA_IN_FETCH=>BTA_IN_FETCH,
				JRTA_IN_FETCH => JTRA_INST,
				JTA_IN_FETCH => JTA_INST,
				rd1inein_DECODE => RD_OUTF,
				PC1in_DECODE => PC_OUTF,
				data=>data);

-------------------------------------------------------------------
-------------------------------------------------------------------
	DECODE_WRITEBACK_PIPE : entity work.p3_decode_wb_no_bypass(structure)
		port map(--DECODE SIGNALS-- 
				wren => CON_DECODE_PIPE(16) ,
				clk => clk,
				rst => rst,
				INSTRUCTION_in_DECODE => RD_OUTF  ,
				PC_1_in_DECODE =>PC_OUTF ,
				WA_in_REG_FILE_DECODE => WAWB,
				WD_in_REG_FILE_DECODE => WB_MUX_WD,
				selEXT => '1'  ,
				selWA => REG_CONTROL   ,
				selBZ => SELBZ_CONTROL ,
			--DECODE OUTPUTS--
				rd1_in_EXECUTE => RD1_OUTD ,
				rd2_in_EXECUTE =>  RD2_OUTD,
				GSE_out_DECODE => CON_GSE ,
				BTA_out_DECODE  => BTA_INST(7 downto 0),
				JR_out_DECODE => JTRA_INST(7 downto 0),
				J_out_DECODE => JTA_INST(7 downto 0),
				PC1EXT32_in_EXECUTE => PC1_OUTD,
				IMMEXT32_in_EXECUTE => IMM_OUTD ,
				SHAMT_in_EXECUTE => SHAMT_OUTD,
				WA_in_EXECUTE => WAOUTD,
			--p3_mcu_no_bypass	ops => CON_OPS,
				ops => CON_OPS,
				funct => CON_FUNT,
				rtforCU =>CON_RTCU, 

			--WRITE BACK SIGNALS-- 
				ReadData_MEMORY_input => RDOUTM,
				ALUWriteAddress_EXECUTE_input =>  ALURem,
				WriteAddress_WB_Input_DECODE =>  WAOUTM,
				IsLoadData_WB_SELECT => CON_WB_PIPE(14),
				--OUTPUTS--
				WriteData_out_WB_in_DECODE => WB_MUX_WD,
				WriteAddress_out_WB_in_DECODE => WAWB );


	EXECUTE_PIPE : entity work.p3_execute_no_bypass(structure)
		port map(	
				clk => clk,
				rst => rst,
				readdata1E => RD1_OUTD  ,
				READDATA2E =>RD2_OUTD ,
                                SHAMTE => SHAMT_OUTD,
				IMME => IMM_OUTD ,
				WRITEADDRESSE => WAOUTD,
				ALUFUNC => CON_EXEC_PIPE(10 downto 7), --ALU CONTROL BITS
                                ALUXSEL => CON_EXEC_PIPE(1 downto 0), --ALU X MUX CONTROLLER SIGNAL
				ALUYSEL => CON_EXEC_PIPE(6 downto 5), --ALU Y MUX CONTROLLER SIGNAL
				--OUTPUTS--
				WRITEADDRESSM => WAOUTE ,
				PC1E => PC1_OUTD,
				ALUDATAE => ALUOUT1E ,
				ALUDATAM => ALUOUT2E,
				ALUADDRESSE => RD2_OUTD);

-------------------------------------------------------------------
-------------------------------------------------------------------
	MEMORY_PIPE : entity work.p3_mem_no_bypass(structure)
		port map(	
				clk => clk,
				rst => rst,
				clken=>'1',
				DMWENM => CON_EXEC_PIPE(12)  ,
				ALUDATAE =>  ALUOUT1E   ,
				ALUDATAM =>  ALUOUT2E   ,
				ALUADDRESSE => RD2_OUTD ,
				WRITEADDRESSM => WAOUTE , 
				--OUTPUTS--
				READDATAWB => RDOUTM ,
				ALUDATAWB  => ALUREM  ,
				WRITADDRESSWB => WAOUTM);

--	DECODE_WRITEBACK_PIPE : entity work.p3_wb_no_bypass(structure)
--		port map(	
--				
--				RDinW => RDOUTM  ,
--				ALUResult2InW   =>  ALURM   ,
--				WAInW     =>  WAOUM   ,
--				selWD => CON_WB_PIPE(14) ,
--				--OUTPUTS--
--				WDinD => WB_MUX_WD ,
--				WAinD  => WAWB );
--


-----------------------------------------------------------------------------------------	
--MAIN CONTROLLER--
	MAIN_CON : entity work.p3_mcu_no_bypass(structure)
		port map(	FUNCT_CODE => CON_FUNT,
				OPCODE => CON_OPS  ,
				GSE => CON_GSE ,
				RT => CON_RTCU ,
				CONTROL_OUT => CON_EXEC_PIPE );

-------------------------------------------------------------------
-------------------------------------------------------------------
--EXECUTE PIPELINED CONTROLLER--

	CON_EXE_PIPED : entity work.p3_piped_mcu_no_bypass(structure)
		port map(	piped_control_IN => CON_EXEC_PIPE ,
				clk => clk  ,
				rst => rst ,
				piped_control_OUT => CON_MEM_PIPE );


-------------------------------------------------------------------
-------------------------------------------------------------------
---MEMORY PIPELINED CONTROLLER--

	CON_MEM_PIPED : entity work.p3_piped_mcu_no_bypass(structure)
		port map(	piped_control_IN => CON_MEM_PIPE ,
				clk => clk  ,
				rst => rst ,
				piped_control_OUT => CON_WB_PIPE  );

-------------------------------------------------------------------
-------------------------------------------------------------------
--WRITEBACK PIPELINED CONTROLLER--

	CON_WB_PIPED : entity work.p3_piped_mcu_no_bypass(structure)
		port map(	piped_control_IN => CON_WB_PIPE ,
				clk => clk  ,
				rst => rst ,
				piped_control_OUT => CON_DECODE_PIPE  );


end architecture structure;