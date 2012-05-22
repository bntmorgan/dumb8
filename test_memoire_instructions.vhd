--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:20:08 05/21/2012
-- Design Name:   
-- Module Name:   U:/Documents/4A/projet_systeme/memoire_instructions/test_memoire_instructions.vhd
-- Project Name:  memoire_instructions
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memoire_instructions
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
 
ENTITY test_memoire_instructions IS
END test_memoire_instructions;
 
ARCHITECTURE behavior OF test_memoire_instructions IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memoire_instructions
    PORT(
         Adr : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         DOUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Adr : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal DOUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memoire_instructions PORT MAP (
          Adr => Adr,
          CLK => CLK,
          DOUT => DOUT
        );

   CLK <= not CLK after CLK_period/2;
    
   Adr <= x"00", x"00" after 10 ns, x"01" after 20 ns, 
          x"02" after 30 ns, x"03" after 40 ns, x"04" after 50 ns;
	

END;
