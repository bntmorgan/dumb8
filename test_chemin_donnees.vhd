--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:16:42 05/25/2012
-- Design Name:   
-- Module Name:   D:/Documents and Settings/sauvanau/Mes documents/Projet_systeme/chemin_de_donnees/test_chemin_donnees.vhd
-- Project Name:  chemin_de_donnees
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: chemin_de_donnees
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
 
ENTITY test_chemin_donnees IS
END test_chemin_donnees;
 
ARCHITECTURE behavior OF test_chemin_donnees IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT chemin_de_donnees
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: chemin_de_donnees PORT MAP (
          CLK => CLK,
          RST => RST
        );

  CLK <= not CLK after CLK_period/2;
  -- Reset actif à 0
  RST <= '1', '0' after 500 ns;

END;