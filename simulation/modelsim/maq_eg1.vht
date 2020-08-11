-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "07/08/2019 13:20:58"
                                                            
-- Vhdl Test Bench template for design  :  maq_eg1
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;                                

ENTITY maq_eg1_vhd_tst IS
END maq_eg1_vhd_tst;
ARCHITECTURE maq_eg1_arch OF maq_eg1_vhd_tst IS
-- constants 
	constant CLOCK_PERIOD: time := 50 ns;
-- signals                                                   
SIGNAL clock_50 : STD_LOGIC :='0';
SIGNAL columnas : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL D_dec : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL D_dec_cent : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL D_uni : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL D_uni_cent : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL D_uni_p : STD_LOGIC;
SIGNAL DIS_VUELTO : STD_LOGIC;
SIGNAL display : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL filas : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL reset_n : STD_LOGIC;
SIGNAL VGA_B : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL VGA_G : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL VGA_HS : STD_LOGIC;
SIGNAL VGA_R : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL VGA_vS : STD_LOGIC;
COMPONENT maq_eg1
	PORT (
	clock_50 : IN STD_LOGIC;
	columnas : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0);
	D_dec : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	D_dec_cent : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	D_uni : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	D_uni_cent : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	D_uni_p : BUFFER STD_LOGIC;
	DIS_VUELTO : IN STD_LOGIC;
	display : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	filas : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	reset_n : IN STD_LOGIC;
	VGA_B : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0);
	VGA_G : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0);
	VGA_HS : BUFFER STD_LOGIC;
	VGA_R : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0);
	VGA_vS : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : maq_eg1 PORT MAP (
-- list connections between master ports and signals
	clock_50 => clock_50,
	columnas => columnas,
	D_dec => D_dec,
	D_dec_cent => D_dec_cent,
	D_uni => D_uni,
	D_uni_cent => D_uni_cent,
	D_uni_p => D_uni_p,
	DIS_VUELTO => DIS_VUELTO,
	display => display,
	filas => filas,
	reset_n => reset_n,
	VGA_B => VGA_B,
	VGA_G => VGA_G,
	VGA_HS => VGA_HS,
	VGA_R => VGA_R,
	VGA_vS => VGA_vS
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init; 
				clock_50 <= not(clock_50) after CLOCK_PERIOD/2;
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations 
					variable cuenta: std_logic_vector(4 downto 0) := (others => '0');
BEGIN                                                         
        -- code executes for every event on sensitivity list 
		
	 for i in 0 to 31 loop
		 cuenta := std_logic_vector(to_unsigned(i,5));	reset_n <= '0';
		 wait for CLOCK_PERIOD;
		 reset_n <= '1';
		
		 filas <= cuenta(4 downto 1);
		 DIS_VUELTO <= cuenta(0);
		 wait for 5*CLOCK_PERIOD;
	end loop;
	
--	reset_n    <= '1';
--	filas      <= "0000";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0001";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0010";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0011";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0100";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0101";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0110";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0111";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1000";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1001";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1010";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1011";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1100";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1101";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1110";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1111";
--	DIS_VUELTO <= '0';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0000";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0001";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0010";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0011";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0100";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0101";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0110";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "0111";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1000";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1001";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1010";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1011";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1100";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1101";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1110";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
--	reset_n    <= '1';
--	filas      <= "1111";
--	DIS_VUELTO <= '1';
--	WAIT FOR CLOCK_PERIOD;
--	
	
	
	
	

WAIT;                                                        
END PROCESS always;                                          
END maq_eg1_arch;
