--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:04:47 05/27/2012
-- Design Name:   
-- Module Name:   /home/garfunk/systeme-sm/processor/processor/test_first_no_nop_op_and_a.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: first_no_nop_op_and_a
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
 
ENTITY test_first_no_nop_op_and_a IS
END test_first_no_nop_op_and_a;
 
ARCHITECTURE behavior OF test_first_no_nop_op_and_a IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT first_no_nop_op_and_a
    PORT(
         di_ex_a : IN  std_logic_vector(7 downto 0);
         di_ex_op : IN  std_logic_vector(7 downto 0);
         ex_mem_a : IN  std_logic_vector(7 downto 0);
         ex_mem_op : IN  std_logic_vector(7 downto 0);
         mem_re_a : IN  std_logic_vector(7 downto 0);
         mem_re_op : IN  std_logic_vector(7 downto 0);
         a_out : OUT  std_logic_vector(7 downto 0);
         op_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal di_ex_a : std_logic_vector(7 downto 0) := (others => '0');
   signal di_ex_op : std_logic_vector(7 downto 0) := (others => '0');
   signal ex_mem_a : std_logic_vector(7 downto 0) := (others => '0');
   signal ex_mem_op : std_logic_vector(7 downto 0) := (others => '0');
   signal mem_re_a : std_logic_vector(7 downto 0) := (others => '0');
   signal mem_re_op : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal a_out : std_logic_vector(7 downto 0);
   signal op_out : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: first_no_nop_op_and_a PORT MAP (
          di_ex_a => di_ex_a,
          di_ex_op => di_ex_op,
          ex_mem_a => ex_mem_a,
          ex_mem_op => ex_mem_op,
          mem_re_a => mem_re_a,
          mem_re_op => mem_re_op,
          a_out => a_out,
          op_out => op_out
        );

	di_ex_op <= x"01", x"00" after 10ns;
	ex_mem_op <= x"02", x"00" after 20ns;
	mem_re_op <= x"03", x"00" after 30ns;
	
	di_ex_a <= x"01";
	ex_mem_a <= x"02";
	mem_re_a <= x"03";


END;
