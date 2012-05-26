--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:23:03 05/21/2012
-- Design Name:   
-- Module Name:   U:/Documents/4A/Projet_systeme/memoire_donnees/test_memoire_donnees.vhd
-- Project Name:  memoire_donnees
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memoire_donnees
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
 
ENTITY test_memoire_donnees IS
END test_memoire_donnees;
 
ARCHITECTURE behavior OF test_memoire_donnees IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memoire_donnees
    PORT(
         Adr : IN  std_logic_vector(7 downto 0);
         DIN : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         DOUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Adr : std_logic_vector(7 downto 0) := (others => '0');
   signal DIN : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal DOUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memoire_donnees PORT MAP (
          Adr => Adr,
          DIN => DIN,
          RW => RW,
          RST => RST,
          CLK => CLK,
          DOUT => DOUT
        );

  CLK <= not CLK after CLK_period/2;
    
  RST <= '1', '0' after 50 ns;
	Din <= x"A0", x"B3" after 10 ns, x"42" after 20 ns, 
                x"D2" after 30 ns, x"B3" after 40 ns, x"9F" after 50 ns;
	RW <= '1', '0' after 40 ns, '1' after 50 ns;
	Adr <= x"00", x"01" after 10 ns, x"01" after 20 ns, x"02" after 30 ns,
                x"01" after 40 ns, x"01" after 50 ns, x"02" after 60 ns;

END;
