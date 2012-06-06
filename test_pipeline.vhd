--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:21:04 05/30/2012
-- Design Name:   
-- Module Name:   D:/Documents and Settings/sauvanau/Mes documents/Projet_systeme/chemin_de_donnees/test_pipeline.vhd
-- Project Name:  chemin_de_donnees
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
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
 
ENTITY test_pipeline IS
END test_pipeline;
 
ARCHITECTURE behavior OF test_pipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
         Op : IN  std_logic_vector(7 downto 0);
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         C : IN  std_logic_vector(7 downto 0);
         Op_out : OUT  std_logic_vector(7 downto 0);
         A_out : OUT  std_logic_vector(7 downto 0);
         B_out : OUT  std_logic_vector(7 downto 0);
         C_out : OUT  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         en : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Op : std_logic_vector(7 downto 0) := (others => '0');
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal C : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal en : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Op_out : std_logic_vector(7 downto 0);
   signal A_out : std_logic_vector(7 downto 0);
   signal B_out : std_logic_vector(7 downto 0);
   signal C_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
          Op => Op,
          A => A,
          B => B,
          C => C,
          Op_out => Op_out,
          A_out => A_out,
          B_out => B_out,
          C_out => C_out,
          CLK => CLK,
          en => en,
          RST => RST
        );

   CLK <= not CLK after CLK_period/2;
  -- Reset actif ра 0
  RST <= '1', '0' after 70 ns;
  en <= '1', '0' after 35 ns;
  Op <= x"00", x"05" after 20 ns, x"A5" after 30 ns, x"FF" after 40 ns;
  A <= x"00", x"05" after 20 ns, x"A5" after 30 ns, x"FF" after 40 ns;
  B <= x"00", x"05" after 20 ns, x"A5" after 30 ns, x"FF" after 40 ns;
  C <= x"00", x"05" after 20 ns, x"A5" after 30 ns, x"FF" after 40 ns;

END;
