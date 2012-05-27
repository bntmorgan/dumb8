--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:22:49 05/27/2012
-- Design Name:   
-- Module Name:   /home/garfunk/systeme-sm/processor/processor/test_aleas_handler.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: aleas_handler
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_aleas_handler IS
END test_aleas_handler;
 
ARCHITECTURE behavior OF test_aleas_handler IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aleas_handler
    PORT(
         op_in : IN  std_logic_vector(7 downto 0);
         a_in : IN  std_logic_vector(7 downto 0);
         li_di_op : IN  std_logic_vector(7 downto 0);
         li_di_b : IN  std_logic_vector(7 downto 0);
         li_di_c : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         clk_out : OUT  std_logic;
         li_di_op_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a_in : std_logic_vector(7 downto 0) := (others => '0');
   signal op_in : std_logic_vector(7 downto 0) := (others => '0');
   signal li_di_b : std_logic_vector(7 downto 0) := (others => '0');
   signal li_di_c : std_logic_vector(7 downto 0) := (others => '0');
   signal li_di_op : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '1';

 	--Outputs
   signal clk_out : std_logic;
   signal li_di_op_out : std_logic_vector(7 downto 0);
	
   -- Clock period definitions
   constant CLK_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aleas_handler PORT MAP (
          op_in => op_in,
          a_in => a_in,
          li_di_op => li_di_op,
          li_di_b => li_di_b,
          li_di_c => li_di_c,
          clk => clk,
          clk_out => clk_out,
          li_di_op_out => li_di_op_out
        );

	clk <= not clk after CLK_period/2;
  
	a_in <= x"00", x"00" after 10 ns, x"00" after 20 ns, x"00" after 30 ns;
	op_in <= x"06", x"06" after 10 ns, x"06" after 20 ns, x"00" after 30 ns;
	li_di_b <= x"00", x"00" after 10 ns, x"01" after 20 ns, x"00" after 30 ns;
	li_di_c <= x"00", x"00" after 10 ns, x"00" after 20 ns, x"00" after 30 ns;
	li_di_op <= x"05", x"01" after 10 ns, x"05" after 20 ns, x"00" after 30 ns;

END;
