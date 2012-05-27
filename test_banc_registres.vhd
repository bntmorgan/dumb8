--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:38:23 05/17/2012
-- Design Name:   
-- Module Name:   U:/Documents/4A/projet_systeme/banc_registres/test_banc_registres.vhd
-- Project Name:  banc_registres
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: banc_registres
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
 
ENTITY test_banc_registres IS
END test_banc_registres;
 
ARCHITECTURE behavior OF test_banc_registres IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT banc_registres
    PORT(
         Adr_A : IN  std_logic_vector(3 downto 0);
         Adr_B : IN  std_logic_vector(3 downto 0);
         Adr_W : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Adr_A : std_logic_vector(3 downto 0) := (others => '0');
   signal Adr_B : std_logic_vector(3 downto 0) := (others => '0');
   signal Adr_W : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	 -- Instantiate the Unit Under Test (UUT)
   uut: banc_registres PORT MAP (
          Adr_A => Adr_A,
          Adr_B => Adr_B,
          Adr_W => Adr_W,
          W => W,
          DATA => DATA,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
        );

  CLK <= not CLK after CLK_period/2;
    
  RST <= '1', '0' after 50 ns;
	DATA <= x"A0", x"B3" after 10 ns, x"42" after 20 ns, x"D2" after 30 ns;
	W <= '1', '0' after 30 ns;
	Adr_W <= "0000", "0001" after 10 ns, "0010" after 20 ns, "0000" after 30 ns;
  Adr_A <= "0000", "0000" after 30 ns, "0010" after 40 ns, "0000" after 50 ns;
  Adr_B <= "0000", "0001" after 30 ns, "0011" after 40 ns, "0000" after 50 ns;
	

END;
