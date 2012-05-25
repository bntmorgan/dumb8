--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:20:17 04/04/2012
-- Design Name:   
-- Module Name:   U:/Documents/4A/TD VHDL/TD_compteur/test_compteur.vhd
-- Project Name:  TD_compteur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: compteur
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY test_compteur IS
END test_compteur;
 
ARCHITECTURE behavior OF test_compteur IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT compteur
    PORT(
         CLK : IN  std_logic;
         SENS : IN  std_logic;
         LOAD : IN  std_logic;
         RST : IN  std_logic;
         EN : IN  std_logic;
         Din : IN  std_logic_vector(7 downto 0);
         Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal SENS : std_logic := '0';
   signal LOAD : std_logic := '0';
   signal RST : std_logic := '0';
   signal EN : std_logic := '0';
   signal Din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: compteur PORT MAP (
          CLK => CLK,
          SENS => SENS,
          LOAD => LOAD,
          RST => RST,
          EN => EN,
          Din => Din,
          Dout => Dout
        ); 

	CLK <= not CLK after CLK_period/2;
	
	RST <= '0', '1' after 30ns, '0' after 300 ns, '1' after 320 ns;
	LOAD <= '0', '1' after 120ns, '0' after 150ns;
	DIN <= x"AB", x"01" after 190ns;
	EN <= '0', '1' after 200ns, '0' after 235ns;
	SENS <= '1', '0' after 250ns, '1' after 400ns;
	
END;