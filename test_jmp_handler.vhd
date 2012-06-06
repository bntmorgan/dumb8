--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:27:10 06/03/2012
-- Design Name:   
-- Module Name:   D:/Documents and Settings/sauvanau/Mes documents/Projet_systeme/chemin_de_donnees/test_jmp_handler.vhd
-- Project Name:  chemin_de_donnees
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: jmp_handler
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
 
ENTITY test_jmp_handler IS
END test_jmp_handler;
 
ARCHITECTURE behavior OF test_jmp_handler IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT jmp_handler
    PORT(
         Op : IN  std_logic_vector(7 downto 0);
         A : IN  std_logic_vector(7 downto 0);
         Z : IN  std_logic;
         RST : OUT  std_logic;
         mem_adr : OUT  std_logic_vector(7 downto 0);
         LOAD : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Op : std_logic_vector(7 downto 0) := (others => '0');
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal Z : std_logic := '0';

 	--Outputs
   signal RST : std_logic;
   signal mem_adr : std_logic_vector(7 downto 0);
   signal LOAD : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: jmp_handler PORT MAP (
          Op => Op,
          A => A,
          Z => Z,
          RST => RST,
          mem_adr => mem_adr,
          LOAD => LOAD
        );
 
 Op <= x"0A", x"A0" after 10 ns, x"06" after 20 ns, x"09" after 30 ns, x"09" after 40 ns;
 A  <= x"FF", x"FF" after 10 ns, x"FF" after 20 ns, x"FF" after 30 ns, x"FF" after 40 ns;
 Z  <= '0', '1' after 10 ns, '1' after 20 ns, '0' after 30 ns, '0' after 40 ns;

END;
