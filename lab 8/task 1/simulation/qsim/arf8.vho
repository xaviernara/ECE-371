-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.0.0 Build 595 04/25/2017 SJ Standard Edition"

-- DATE "02/28/2018 16:21:04"

-- 
-- Device: Altera EP4CE6E22C6 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	arf8 IS
    PORT (
	clk : IN std_logic;
	rst : IN std_logic;
	wrEn : IN std_logic;
	rdAddr1 : IN std_logic_vector(2 DOWNTO 0);
	rdAddr2 : IN std_logic_vector(2 DOWNTO 0);
	wrAddr : IN std_logic_vector(2 DOWNTO 0);
	wrData : IN std_logic_vector(3 DOWNTO 0);
	rdData1 : OUT std_logic_vector(3 DOWNTO 0);
	rdData2 : OUT std_logic_vector(3 DOWNTO 0)
	);
END arf8;

ARCHITECTURE structure OF arf8 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst : std_logic;
SIGNAL ww_wrEn : std_logic;
SIGNAL ww_rdAddr1 : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_rdAddr2 : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_wrAddr : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_wrData : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_rdData1 : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_rdData2 : std_logic_vector(3 DOWNTO 0);
SIGNAL \rdData1[0]~output_o\ : std_logic;
SIGNAL \rdData1[1]~output_o\ : std_logic;
SIGNAL \rdData1[2]~output_o\ : std_logic;
SIGNAL \rdData1[3]~output_o\ : std_logic;
SIGNAL \rdData2[0]~output_o\ : std_logic;
SIGNAL \rdData2[1]~output_o\ : std_logic;
SIGNAL \rdData2[2]~output_o\ : std_logic;
SIGNAL \rdData2[3]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \wrData[0]~input_o\ : std_logic;
SIGNAL \rst~input_o\ : std_logic;
SIGNAL \wrAddr[1]~input_o\ : std_logic;
SIGNAL \wrEn~input_o\ : std_logic;
SIGNAL \wrAddr[0]~input_o\ : std_logic;
SIGNAL \wrAddr[2]~input_o\ : std_logic;
SIGNAL \WriteAddressBlock|Mux5~0_combout\ : std_logic;
SIGNAL \WriteAddressBlock|Mux4~0_combout\ : std_logic;
SIGNAL \rdAddr1[1]~input_o\ : std_logic;
SIGNAL \rdAddr1[2]~input_o\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~0_combout\ : std_logic;
SIGNAL \WriteAddressBlock|Mux6~0_combout\ : std_logic;
SIGNAL \WriteAddressBlock|Mux1~0_combout\ : std_logic;
SIGNAL \WriteAddressBlock|Mux2~0_combout\ : std_logic;
SIGNAL \rdAddr1[0]~input_o\ : std_logic;
SIGNAL \WriteAddressBlock|Mux3~0_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~1_combout\ : std_logic;
SIGNAL \WriteAddressBlock|Mux0~0_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~2_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~3_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~4_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~5_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux3~combout\ : std_logic;
SIGNAL \wrData[1]~input_o\ : std_logic;
SIGNAL \Read1AddressBlock|Mux2~0_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux2~1_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux2~2_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux2~combout\ : std_logic;
SIGNAL \wrData[2]~input_o\ : std_logic;
SIGNAL \Read1AddressBlock|Mux1~0_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux1~1_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux1~2_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux1~combout\ : std_logic;
SIGNAL \wrData[3]~input_o\ : std_logic;
SIGNAL \Read1AddressBlock|Mux0~0_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux0~1_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux0~2_combout\ : std_logic;
SIGNAL \Read1AddressBlock|Mux0~combout\ : std_logic;
SIGNAL \rdAddr2[1]~input_o\ : std_logic;
SIGNAL \rdAddr2[2]~input_o\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~0_combout\ : std_logic;
SIGNAL \rdAddr2[0]~input_o\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~1_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~2_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~3_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~4_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~5_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux3~combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux2~0_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux2~1_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux2~2_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux2~combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux1~0_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux1~1_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux1~2_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux1~combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux0~0_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux0~1_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux0~2_combout\ : std_logic;
SIGNAL \Read2AddressBlock|Mux0~combout\ : std_logic;
SIGNAL \HardWired:flopsBlock:2:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \HardWired:flopsBlock:3:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \HardWired:flopsBlock:4:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \HardWired:flopsBlock:1:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \HardWired:flopsBlock:6:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \HardWired:flopsBlock:5:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \HardWired:flopsBlock:7:dFlop|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_rst~input_o\ : std_logic;

BEGIN

ww_clk <= clk;
ww_rst <= rst;
ww_wrEn <= wrEn;
ww_rdAddr1 <= rdAddr1;
ww_rdAddr2 <= rdAddr2;
ww_wrAddr <= wrAddr;
ww_wrData <= wrData;
rdData1 <= ww_rdData1;
rdData2 <= ww_rdData2;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_rst~input_o\ <= NOT \rst~input_o\;

\rdData1[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read1AddressBlock|Mux3~combout\,
	devoe => ww_devoe,
	o => \rdData1[0]~output_o\);

\rdData1[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read1AddressBlock|Mux2~combout\,
	devoe => ww_devoe,
	o => \rdData1[1]~output_o\);

\rdData1[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read1AddressBlock|Mux1~combout\,
	devoe => ww_devoe,
	o => \rdData1[2]~output_o\);

\rdData1[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read1AddressBlock|Mux0~combout\,
	devoe => ww_devoe,
	o => \rdData1[3]~output_o\);

\rdData2[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read2AddressBlock|Mux3~combout\,
	devoe => ww_devoe,
	o => \rdData2[0]~output_o\);

\rdData2[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read2AddressBlock|Mux2~combout\,
	devoe => ww_devoe,
	o => \rdData2[1]~output_o\);

\rdData2[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read2AddressBlock|Mux1~combout\,
	devoe => ww_devoe,
	o => \rdData2[2]~output_o\);

\rdData2[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Read2AddressBlock|Mux0~combout\,
	devoe => ww_devoe,
	o => \rdData2[3]~output_o\);

\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

\wrData[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrData(0),
	o => \wrData[0]~input_o\);

\rst~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst,
	o => \rst~input_o\);

\wrAddr[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrAddr(1),
	o => \wrAddr[1]~input_o\);

\wrEn~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrEn,
	o => \wrEn~input_o\);

\wrAddr[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrAddr(0),
	o => \wrAddr[0]~input_o\);

\wrAddr[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrAddr(2),
	o => \wrAddr[2]~input_o\);

\WriteAddressBlock|Mux5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux5~0_combout\ = (\wrAddr[1]~input_o\ & (\wrEn~input_o\ & (!\wrAddr[0]~input_o\ & !\wrAddr[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrAddr[1]~input_o\,
	datab => \wrEn~input_o\,
	datac => \wrAddr[0]~input_o\,
	datad => \wrAddr[2]~input_o\,
	combout => \WriteAddressBlock|Mux5~0_combout\);

\HardWired:flopsBlock:2:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:2:dFlop|q\(0));

\WriteAddressBlock|Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux4~0_combout\ = (\wrAddr[0]~input_o\ & (\wrAddr[1]~input_o\ & (\wrEn~input_o\ & !\wrAddr[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrAddr[0]~input_o\,
	datab => \wrAddr[1]~input_o\,
	datac => \wrEn~input_o\,
	datad => \wrAddr[2]~input_o\,
	combout => \WriteAddressBlock|Mux4~0_combout\);

\HardWired:flopsBlock:3:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:3:dFlop|q\(0));

\rdAddr1[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rdAddr1(1),
	o => \rdAddr1[1]~input_o\);

\rdAddr1[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rdAddr1(2),
	o => \rdAddr1[2]~input_o\);

\Read1AddressBlock|Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~0_combout\ = (\rdAddr1[1]~input_o\ & !\rdAddr1[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[1]~input_o\,
	datad => \rdAddr1[2]~input_o\,
	combout => \Read1AddressBlock|Mux3~0_combout\);

\WriteAddressBlock|Mux6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux6~0_combout\ = (\wrAddr[0]~input_o\ & (\wrEn~input_o\ & (!\wrAddr[1]~input_o\ & !\wrAddr[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrAddr[0]~input_o\,
	datab => \wrEn~input_o\,
	datac => \wrAddr[1]~input_o\,
	datad => \wrAddr[2]~input_o\,
	combout => \WriteAddressBlock|Mux6~0_combout\);

\HardWired:flopsBlock:1:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:1:dFlop|q\(0));

\WriteAddressBlock|Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux1~0_combout\ = (\wrAddr[1]~input_o\ & (\wrEn~input_o\ & (\wrAddr[2]~input_o\ & !\wrAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrAddr[1]~input_o\,
	datab => \wrEn~input_o\,
	datac => \wrAddr[2]~input_o\,
	datad => \wrAddr[0]~input_o\,
	combout => \WriteAddressBlock|Mux1~0_combout\);

\HardWired:flopsBlock:6:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:6:dFlop|q\(0));

\WriteAddressBlock|Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux2~0_combout\ = (\wrAddr[0]~input_o\ & (\wrEn~input_o\ & (\wrAddr[2]~input_o\ & !\wrAddr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrAddr[0]~input_o\,
	datab => \wrEn~input_o\,
	datac => \wrAddr[2]~input_o\,
	datad => \wrAddr[1]~input_o\,
	combout => \WriteAddressBlock|Mux2~0_combout\);

\HardWired:flopsBlock:5:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:5:dFlop|q\(0));

\rdAddr1[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rdAddr1(0),
	o => \rdAddr1[0]~input_o\);

\WriteAddressBlock|Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux3~0_combout\ = (\wrEn~input_o\ & (\wrAddr[2]~input_o\ & (!\wrAddr[0]~input_o\ & !\wrAddr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrEn~input_o\,
	datab => \wrAddr[2]~input_o\,
	datac => \wrAddr[0]~input_o\,
	datad => \wrAddr[1]~input_o\,
	combout => \WriteAddressBlock|Mux3~0_combout\);

\HardWired:flopsBlock:4:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:4:dFlop|q\(0));

\Read1AddressBlock|Mux3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~1_combout\ = (\rdAddr1[1]~input_o\ & (((\rdAddr1[0]~input_o\)))) # (!\rdAddr1[1]~input_o\ & ((\rdAddr1[0]~input_o\ & (\HardWired:flopsBlock:5:dFlop|q\(0))) # (!\rdAddr1[0]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[1]~input_o\,
	datab => \HardWired:flopsBlock:5:dFlop|q\(0),
	datac => \rdAddr1[0]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(0),
	combout => \Read1AddressBlock|Mux3~1_combout\);

\WriteAddressBlock|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WriteAddressBlock|Mux0~0_combout\ = (\wrAddr[0]~input_o\ & (\wrAddr[1]~input_o\ & (\wrEn~input_o\ & \wrAddr[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \wrAddr[0]~input_o\,
	datab => \wrAddr[1]~input_o\,
	datac => \wrEn~input_o\,
	datad => \wrAddr[2]~input_o\,
	combout => \WriteAddressBlock|Mux0~0_combout\);

\HardWired:flopsBlock:7:dFlop|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[0]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:7:dFlop|q\(0));

\Read1AddressBlock|Mux3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~2_combout\ = (\rdAddr1[1]~input_o\ & ((\Read1AddressBlock|Mux3~1_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(0)))) # (!\Read1AddressBlock|Mux3~1_combout\ & (\HardWired:flopsBlock:6:dFlop|q\(0))))) # (!\rdAddr1[1]~input_o\ & 
-- (((\Read1AddressBlock|Mux3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:6:dFlop|q\(0),
	datab => \rdAddr1[1]~input_o\,
	datac => \Read1AddressBlock|Mux3~1_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(0),
	combout => \Read1AddressBlock|Mux3~2_combout\);

\Read1AddressBlock|Mux3~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~3_combout\ = (\rdAddr1[2]~input_o\) # ((\rdAddr1[0]~input_o\ & !\rdAddr1[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[2]~input_o\,
	datab => \rdAddr1[0]~input_o\,
	datad => \rdAddr1[1]~input_o\,
	combout => \Read1AddressBlock|Mux3~3_combout\);

\Read1AddressBlock|Mux3~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~4_combout\ = (\rdAddr1[2]~input_o\) # ((\rdAddr1[1]~input_o\ & \rdAddr1[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[2]~input_o\,
	datab => \rdAddr1[1]~input_o\,
	datac => \rdAddr1[0]~input_o\,
	combout => \Read1AddressBlock|Mux3~4_combout\);

\Read1AddressBlock|Mux3~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~5_combout\ = (\Read1AddressBlock|Mux3~3_combout\ & ((\Read1AddressBlock|Mux3~4_combout\ & ((\Read1AddressBlock|Mux3~2_combout\))) # (!\Read1AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(0))))) # 
-- (!\Read1AddressBlock|Mux3~3_combout\ & (((\Read1AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(0),
	datab => \Read1AddressBlock|Mux3~2_combout\,
	datac => \Read1AddressBlock|Mux3~3_combout\,
	datad => \Read1AddressBlock|Mux3~4_combout\,
	combout => \Read1AddressBlock|Mux3~5_combout\);

\Read1AddressBlock|Mux3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux3~combout\ = (\Read1AddressBlock|Mux3~0_combout\ & ((\Read1AddressBlock|Mux3~5_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(0)))) # (!\Read1AddressBlock|Mux3~5_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(0))))) # 
-- (!\Read1AddressBlock|Mux3~0_combout\ & (((\Read1AddressBlock|Mux3~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(0),
	datab => \HardWired:flopsBlock:3:dFlop|q\(0),
	datac => \Read1AddressBlock|Mux3~0_combout\,
	datad => \Read1AddressBlock|Mux3~5_combout\,
	combout => \Read1AddressBlock|Mux3~combout\);

\wrData[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrData(1),
	o => \wrData[1]~input_o\);

\HardWired:flopsBlock:2:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:2:dFlop|q\(1));

\HardWired:flopsBlock:3:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:3:dFlop|q\(1));

\HardWired:flopsBlock:1:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:1:dFlop|q\(1));

\HardWired:flopsBlock:6:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:6:dFlop|q\(1));

\HardWired:flopsBlock:5:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:5:dFlop|q\(1));

\HardWired:flopsBlock:4:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:4:dFlop|q\(1));

\Read1AddressBlock|Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux2~0_combout\ = (\rdAddr1[1]~input_o\ & (((\rdAddr1[0]~input_o\)))) # (!\rdAddr1[1]~input_o\ & ((\rdAddr1[0]~input_o\ & (\HardWired:flopsBlock:5:dFlop|q\(1))) # (!\rdAddr1[0]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[1]~input_o\,
	datab => \HardWired:flopsBlock:5:dFlop|q\(1),
	datac => \rdAddr1[0]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(1),
	combout => \Read1AddressBlock|Mux2~0_combout\);

\HardWired:flopsBlock:7:dFlop|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[1]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:7:dFlop|q\(1));

\Read1AddressBlock|Mux2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux2~1_combout\ = (\rdAddr1[1]~input_o\ & ((\Read1AddressBlock|Mux2~0_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(1)))) # (!\Read1AddressBlock|Mux2~0_combout\ & (\HardWired:flopsBlock:6:dFlop|q\(1))))) # (!\rdAddr1[1]~input_o\ & 
-- (((\Read1AddressBlock|Mux2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:6:dFlop|q\(1),
	datab => \rdAddr1[1]~input_o\,
	datac => \Read1AddressBlock|Mux2~0_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(1),
	combout => \Read1AddressBlock|Mux2~1_combout\);

\Read1AddressBlock|Mux2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux2~2_combout\ = (\Read1AddressBlock|Mux3~3_combout\ & ((\Read1AddressBlock|Mux3~4_combout\ & ((\Read1AddressBlock|Mux2~1_combout\))) # (!\Read1AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(1))))) # 
-- (!\Read1AddressBlock|Mux3~3_combout\ & (((\Read1AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(1),
	datab => \Read1AddressBlock|Mux2~1_combout\,
	datac => \Read1AddressBlock|Mux3~3_combout\,
	datad => \Read1AddressBlock|Mux3~4_combout\,
	combout => \Read1AddressBlock|Mux2~2_combout\);

\Read1AddressBlock|Mux2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux2~combout\ = (\Read1AddressBlock|Mux3~0_combout\ & ((\Read1AddressBlock|Mux2~2_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(1)))) # (!\Read1AddressBlock|Mux2~2_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(1))))) # 
-- (!\Read1AddressBlock|Mux3~0_combout\ & (((\Read1AddressBlock|Mux2~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(1),
	datab => \HardWired:flopsBlock:3:dFlop|q\(1),
	datac => \Read1AddressBlock|Mux3~0_combout\,
	datad => \Read1AddressBlock|Mux2~2_combout\,
	combout => \Read1AddressBlock|Mux2~combout\);

\wrData[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrData(2),
	o => \wrData[2]~input_o\);

\HardWired:flopsBlock:2:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:2:dFlop|q\(2));

\HardWired:flopsBlock:3:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:3:dFlop|q\(2));

\HardWired:flopsBlock:1:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:1:dFlop|q\(2));

\HardWired:flopsBlock:5:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:5:dFlop|q\(2));

\HardWired:flopsBlock:6:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:6:dFlop|q\(2));

\HardWired:flopsBlock:4:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:4:dFlop|q\(2));

\Read1AddressBlock|Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux1~0_combout\ = (\rdAddr1[0]~input_o\ & (((\rdAddr1[1]~input_o\)))) # (!\rdAddr1[0]~input_o\ & ((\rdAddr1[1]~input_o\ & (\HardWired:flopsBlock:6:dFlop|q\(2))) # (!\rdAddr1[1]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[0]~input_o\,
	datab => \HardWired:flopsBlock:6:dFlop|q\(2),
	datac => \rdAddr1[1]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(2),
	combout => \Read1AddressBlock|Mux1~0_combout\);

\HardWired:flopsBlock:7:dFlop|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[2]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:7:dFlop|q\(2));

\Read1AddressBlock|Mux1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux1~1_combout\ = (\rdAddr1[0]~input_o\ & ((\Read1AddressBlock|Mux1~0_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(2)))) # (!\Read1AddressBlock|Mux1~0_combout\ & (\HardWired:flopsBlock:5:dFlop|q\(2))))) # (!\rdAddr1[0]~input_o\ & 
-- (((\Read1AddressBlock|Mux1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:5:dFlop|q\(2),
	datab => \rdAddr1[0]~input_o\,
	datac => \Read1AddressBlock|Mux1~0_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(2),
	combout => \Read1AddressBlock|Mux1~1_combout\);

\Read1AddressBlock|Mux1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux1~2_combout\ = (\Read1AddressBlock|Mux3~3_combout\ & ((\Read1AddressBlock|Mux3~4_combout\ & ((\Read1AddressBlock|Mux1~1_combout\))) # (!\Read1AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(2))))) # 
-- (!\Read1AddressBlock|Mux3~3_combout\ & (((\Read1AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(2),
	datab => \Read1AddressBlock|Mux1~1_combout\,
	datac => \Read1AddressBlock|Mux3~3_combout\,
	datad => \Read1AddressBlock|Mux3~4_combout\,
	combout => \Read1AddressBlock|Mux1~2_combout\);

\Read1AddressBlock|Mux1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux1~combout\ = (\Read1AddressBlock|Mux3~0_combout\ & ((\Read1AddressBlock|Mux1~2_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(2)))) # (!\Read1AddressBlock|Mux1~2_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(2))))) # 
-- (!\Read1AddressBlock|Mux3~0_combout\ & (((\Read1AddressBlock|Mux1~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(2),
	datab => \HardWired:flopsBlock:3:dFlop|q\(2),
	datac => \Read1AddressBlock|Mux3~0_combout\,
	datad => \Read1AddressBlock|Mux1~2_combout\,
	combout => \Read1AddressBlock|Mux1~combout\);

\wrData[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wrData(3),
	o => \wrData[3]~input_o\);

\HardWired:flopsBlock:2:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:2:dFlop|q\(3));

\HardWired:flopsBlock:3:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:3:dFlop|q\(3));

\HardWired:flopsBlock:1:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:1:dFlop|q\(3));

\HardWired:flopsBlock:6:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:6:dFlop|q\(3));

\HardWired:flopsBlock:5:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:5:dFlop|q\(3));

\HardWired:flopsBlock:4:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:4:dFlop|q\(3));

\Read1AddressBlock|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux0~0_combout\ = (\rdAddr1[1]~input_o\ & (((\rdAddr1[0]~input_o\)))) # (!\rdAddr1[1]~input_o\ & ((\rdAddr1[0]~input_o\ & (\HardWired:flopsBlock:5:dFlop|q\(3))) # (!\rdAddr1[0]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr1[1]~input_o\,
	datab => \HardWired:flopsBlock:5:dFlop|q\(3),
	datac => \rdAddr1[0]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(3),
	combout => \Read1AddressBlock|Mux0~0_combout\);

\HardWired:flopsBlock:7:dFlop|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \wrData[3]~input_o\,
	clrn => \ALT_INV_rst~input_o\,
	ena => \WriteAddressBlock|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \HardWired:flopsBlock:7:dFlop|q\(3));

\Read1AddressBlock|Mux0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux0~1_combout\ = (\rdAddr1[1]~input_o\ & ((\Read1AddressBlock|Mux0~0_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(3)))) # (!\Read1AddressBlock|Mux0~0_combout\ & (\HardWired:flopsBlock:6:dFlop|q\(3))))) # (!\rdAddr1[1]~input_o\ & 
-- (((\Read1AddressBlock|Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:6:dFlop|q\(3),
	datab => \rdAddr1[1]~input_o\,
	datac => \Read1AddressBlock|Mux0~0_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(3),
	combout => \Read1AddressBlock|Mux0~1_combout\);

\Read1AddressBlock|Mux0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux0~2_combout\ = (\Read1AddressBlock|Mux3~3_combout\ & ((\Read1AddressBlock|Mux3~4_combout\ & ((\Read1AddressBlock|Mux0~1_combout\))) # (!\Read1AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(3))))) # 
-- (!\Read1AddressBlock|Mux3~3_combout\ & (((\Read1AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(3),
	datab => \Read1AddressBlock|Mux0~1_combout\,
	datac => \Read1AddressBlock|Mux3~3_combout\,
	datad => \Read1AddressBlock|Mux3~4_combout\,
	combout => \Read1AddressBlock|Mux0~2_combout\);

\Read1AddressBlock|Mux0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read1AddressBlock|Mux0~combout\ = (\Read1AddressBlock|Mux3~0_combout\ & ((\Read1AddressBlock|Mux0~2_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(3)))) # (!\Read1AddressBlock|Mux0~2_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(3))))) # 
-- (!\Read1AddressBlock|Mux3~0_combout\ & (((\Read1AddressBlock|Mux0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(3),
	datab => \HardWired:flopsBlock:3:dFlop|q\(3),
	datac => \Read1AddressBlock|Mux3~0_combout\,
	datad => \Read1AddressBlock|Mux0~2_combout\,
	combout => \Read1AddressBlock|Mux0~combout\);

\rdAddr2[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rdAddr2(1),
	o => \rdAddr2[1]~input_o\);

\rdAddr2[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rdAddr2(2),
	o => \rdAddr2[2]~input_o\);

\Read2AddressBlock|Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~0_combout\ = (\rdAddr2[1]~input_o\ & !\rdAddr2[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[1]~input_o\,
	datad => \rdAddr2[2]~input_o\,
	combout => \Read2AddressBlock|Mux3~0_combout\);

\rdAddr2[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rdAddr2(0),
	o => \rdAddr2[0]~input_o\);

\Read2AddressBlock|Mux3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~1_combout\ = (\rdAddr2[1]~input_o\ & (((\rdAddr2[0]~input_o\)))) # (!\rdAddr2[1]~input_o\ & ((\rdAddr2[0]~input_o\ & (\HardWired:flopsBlock:5:dFlop|q\(0))) # (!\rdAddr2[0]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[1]~input_o\,
	datab => \HardWired:flopsBlock:5:dFlop|q\(0),
	datac => \rdAddr2[0]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(0),
	combout => \Read2AddressBlock|Mux3~1_combout\);

\Read2AddressBlock|Mux3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~2_combout\ = (\rdAddr2[1]~input_o\ & ((\Read2AddressBlock|Mux3~1_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(0)))) # (!\Read2AddressBlock|Mux3~1_combout\ & (\HardWired:flopsBlock:6:dFlop|q\(0))))) # (!\rdAddr2[1]~input_o\ & 
-- (((\Read2AddressBlock|Mux3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:6:dFlop|q\(0),
	datab => \rdAddr2[1]~input_o\,
	datac => \Read2AddressBlock|Mux3~1_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(0),
	combout => \Read2AddressBlock|Mux3~2_combout\);

\Read2AddressBlock|Mux3~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~3_combout\ = (\rdAddr2[2]~input_o\) # ((\rdAddr2[0]~input_o\ & !\rdAddr2[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[2]~input_o\,
	datab => \rdAddr2[0]~input_o\,
	datad => \rdAddr2[1]~input_o\,
	combout => \Read2AddressBlock|Mux3~3_combout\);

\Read2AddressBlock|Mux3~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~4_combout\ = (\rdAddr2[2]~input_o\) # ((\rdAddr2[1]~input_o\ & \rdAddr2[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[2]~input_o\,
	datab => \rdAddr2[1]~input_o\,
	datac => \rdAddr2[0]~input_o\,
	combout => \Read2AddressBlock|Mux3~4_combout\);

\Read2AddressBlock|Mux3~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~5_combout\ = (\Read2AddressBlock|Mux3~3_combout\ & ((\Read2AddressBlock|Mux3~4_combout\ & ((\Read2AddressBlock|Mux3~2_combout\))) # (!\Read2AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(0))))) # 
-- (!\Read2AddressBlock|Mux3~3_combout\ & (((\Read2AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(0),
	datab => \Read2AddressBlock|Mux3~2_combout\,
	datac => \Read2AddressBlock|Mux3~3_combout\,
	datad => \Read2AddressBlock|Mux3~4_combout\,
	combout => \Read2AddressBlock|Mux3~5_combout\);

\Read2AddressBlock|Mux3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux3~combout\ = (\Read2AddressBlock|Mux3~0_combout\ & ((\Read2AddressBlock|Mux3~5_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(0)))) # (!\Read2AddressBlock|Mux3~5_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(0))))) # 
-- (!\Read2AddressBlock|Mux3~0_combout\ & (((\Read2AddressBlock|Mux3~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(0),
	datab => \HardWired:flopsBlock:3:dFlop|q\(0),
	datac => \Read2AddressBlock|Mux3~0_combout\,
	datad => \Read2AddressBlock|Mux3~5_combout\,
	combout => \Read2AddressBlock|Mux3~combout\);

\Read2AddressBlock|Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux2~0_combout\ = (\rdAddr2[1]~input_o\ & (((\rdAddr2[0]~input_o\)))) # (!\rdAddr2[1]~input_o\ & ((\rdAddr2[0]~input_o\ & (\HardWired:flopsBlock:5:dFlop|q\(1))) # (!\rdAddr2[0]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[1]~input_o\,
	datab => \HardWired:flopsBlock:5:dFlop|q\(1),
	datac => \rdAddr2[0]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(1),
	combout => \Read2AddressBlock|Mux2~0_combout\);

\Read2AddressBlock|Mux2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux2~1_combout\ = (\rdAddr2[1]~input_o\ & ((\Read2AddressBlock|Mux2~0_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(1)))) # (!\Read2AddressBlock|Mux2~0_combout\ & (\HardWired:flopsBlock:6:dFlop|q\(1))))) # (!\rdAddr2[1]~input_o\ & 
-- (((\Read2AddressBlock|Mux2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:6:dFlop|q\(1),
	datab => \rdAddr2[1]~input_o\,
	datac => \Read2AddressBlock|Mux2~0_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(1),
	combout => \Read2AddressBlock|Mux2~1_combout\);

\Read2AddressBlock|Mux2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux2~2_combout\ = (\Read2AddressBlock|Mux3~3_combout\ & ((\Read2AddressBlock|Mux3~4_combout\ & ((\Read2AddressBlock|Mux2~1_combout\))) # (!\Read2AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(1))))) # 
-- (!\Read2AddressBlock|Mux3~3_combout\ & (((\Read2AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(1),
	datab => \Read2AddressBlock|Mux2~1_combout\,
	datac => \Read2AddressBlock|Mux3~3_combout\,
	datad => \Read2AddressBlock|Mux3~4_combout\,
	combout => \Read2AddressBlock|Mux2~2_combout\);

\Read2AddressBlock|Mux2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux2~combout\ = (\Read2AddressBlock|Mux3~0_combout\ & ((\Read2AddressBlock|Mux2~2_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(1)))) # (!\Read2AddressBlock|Mux2~2_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(1))))) # 
-- (!\Read2AddressBlock|Mux3~0_combout\ & (((\Read2AddressBlock|Mux2~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(1),
	datab => \HardWired:flopsBlock:3:dFlop|q\(1),
	datac => \Read2AddressBlock|Mux3~0_combout\,
	datad => \Read2AddressBlock|Mux2~2_combout\,
	combout => \Read2AddressBlock|Mux2~combout\);

\Read2AddressBlock|Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux1~0_combout\ = (\rdAddr2[0]~input_o\ & (((\rdAddr2[1]~input_o\)))) # (!\rdAddr2[0]~input_o\ & ((\rdAddr2[1]~input_o\ & (\HardWired:flopsBlock:6:dFlop|q\(2))) # (!\rdAddr2[1]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[0]~input_o\,
	datab => \HardWired:flopsBlock:6:dFlop|q\(2),
	datac => \rdAddr2[1]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(2),
	combout => \Read2AddressBlock|Mux1~0_combout\);

\Read2AddressBlock|Mux1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux1~1_combout\ = (\rdAddr2[0]~input_o\ & ((\Read2AddressBlock|Mux1~0_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(2)))) # (!\Read2AddressBlock|Mux1~0_combout\ & (\HardWired:flopsBlock:5:dFlop|q\(2))))) # (!\rdAddr2[0]~input_o\ & 
-- (((\Read2AddressBlock|Mux1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:5:dFlop|q\(2),
	datab => \rdAddr2[0]~input_o\,
	datac => \Read2AddressBlock|Mux1~0_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(2),
	combout => \Read2AddressBlock|Mux1~1_combout\);

\Read2AddressBlock|Mux1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux1~2_combout\ = (\Read2AddressBlock|Mux3~3_combout\ & ((\Read2AddressBlock|Mux3~4_combout\ & ((\Read2AddressBlock|Mux1~1_combout\))) # (!\Read2AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(2))))) # 
-- (!\Read2AddressBlock|Mux3~3_combout\ & (((\Read2AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(2),
	datab => \Read2AddressBlock|Mux1~1_combout\,
	datac => \Read2AddressBlock|Mux3~3_combout\,
	datad => \Read2AddressBlock|Mux3~4_combout\,
	combout => \Read2AddressBlock|Mux1~2_combout\);

\Read2AddressBlock|Mux1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux1~combout\ = (\Read2AddressBlock|Mux3~0_combout\ & ((\Read2AddressBlock|Mux1~2_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(2)))) # (!\Read2AddressBlock|Mux1~2_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(2))))) # 
-- (!\Read2AddressBlock|Mux3~0_combout\ & (((\Read2AddressBlock|Mux1~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(2),
	datab => \HardWired:flopsBlock:3:dFlop|q\(2),
	datac => \Read2AddressBlock|Mux3~0_combout\,
	datad => \Read2AddressBlock|Mux1~2_combout\,
	combout => \Read2AddressBlock|Mux1~combout\);

\Read2AddressBlock|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux0~0_combout\ = (\rdAddr2[1]~input_o\ & (((\rdAddr2[0]~input_o\)))) # (!\rdAddr2[1]~input_o\ & ((\rdAddr2[0]~input_o\ & (\HardWired:flopsBlock:5:dFlop|q\(3))) # (!\rdAddr2[0]~input_o\ & ((\HardWired:flopsBlock:4:dFlop|q\(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rdAddr2[1]~input_o\,
	datab => \HardWired:flopsBlock:5:dFlop|q\(3),
	datac => \rdAddr2[0]~input_o\,
	datad => \HardWired:flopsBlock:4:dFlop|q\(3),
	combout => \Read2AddressBlock|Mux0~0_combout\);

\Read2AddressBlock|Mux0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux0~1_combout\ = (\rdAddr2[1]~input_o\ & ((\Read2AddressBlock|Mux0~0_combout\ & ((\HardWired:flopsBlock:7:dFlop|q\(3)))) # (!\Read2AddressBlock|Mux0~0_combout\ & (\HardWired:flopsBlock:6:dFlop|q\(3))))) # (!\rdAddr2[1]~input_o\ & 
-- (((\Read2AddressBlock|Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:6:dFlop|q\(3),
	datab => \rdAddr2[1]~input_o\,
	datac => \Read2AddressBlock|Mux0~0_combout\,
	datad => \HardWired:flopsBlock:7:dFlop|q\(3),
	combout => \Read2AddressBlock|Mux0~1_combout\);

\Read2AddressBlock|Mux0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux0~2_combout\ = (\Read2AddressBlock|Mux3~3_combout\ & ((\Read2AddressBlock|Mux3~4_combout\ & ((\Read2AddressBlock|Mux0~1_combout\))) # (!\Read2AddressBlock|Mux3~4_combout\ & (\HardWired:flopsBlock:1:dFlop|q\(3))))) # 
-- (!\Read2AddressBlock|Mux3~3_combout\ & (((\Read2AddressBlock|Mux3~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:1:dFlop|q\(3),
	datab => \Read2AddressBlock|Mux0~1_combout\,
	datac => \Read2AddressBlock|Mux3~3_combout\,
	datad => \Read2AddressBlock|Mux3~4_combout\,
	combout => \Read2AddressBlock|Mux0~2_combout\);

\Read2AddressBlock|Mux0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Read2AddressBlock|Mux0~combout\ = (\Read2AddressBlock|Mux3~0_combout\ & ((\Read2AddressBlock|Mux0~2_combout\ & ((\HardWired:flopsBlock:3:dFlop|q\(3)))) # (!\Read2AddressBlock|Mux0~2_combout\ & (\HardWired:flopsBlock:2:dFlop|q\(3))))) # 
-- (!\Read2AddressBlock|Mux3~0_combout\ & (((\Read2AddressBlock|Mux0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \HardWired:flopsBlock:2:dFlop|q\(3),
	datab => \HardWired:flopsBlock:3:dFlop|q\(3),
	datac => \Read2AddressBlock|Mux3~0_combout\,
	datad => \Read2AddressBlock|Mux0~2_combout\,
	combout => \Read2AddressBlock|Mux0~combout\);

ww_rdData1(0) <= \rdData1[0]~output_o\;

ww_rdData1(1) <= \rdData1[1]~output_o\;

ww_rdData1(2) <= \rdData1[2]~output_o\;

ww_rdData1(3) <= \rdData1[3]~output_o\;

ww_rdData2(0) <= \rdData2[0]~output_o\;

ww_rdData2(1) <= \rdData2[1]~output_o\;

ww_rdData2(2) <= \rdData2[2]~output_o\;

ww_rdData2(3) <= \rdData2[3]~output_o\;
END structure;


