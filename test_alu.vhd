-- Copyright (C) 2012 Carla Sauvanaud
-- Copyright (C) 2012, 2016  Benoît Morgan
--
-- This file is part of dumb8.
--
-- dumb8 is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- dumb8 is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with dumb8.  If not, see <http://www.gnu.org/licenses/>.

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:40:19 05/16/2012
-- Design Name:   
-- Module Name:   U:/Documents/4A/projet_systeme/alu/test_alu.vhd
-- Project Name:  alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
 
ENTITY test_alu IS
END test_alu;
 
ARCHITECTURE behavior OF test_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         S : OUT  std_logic_vector(7 downto 0);
         N : OUT  std_logic;
         O : OUT  std_logic;
         Z : OUT  std_logic;
         C : OUT  std_logic;
         Ctrl_Alu : IN  std_logic_vector(2 downto 0);
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');
   signal A : std_logic_vector(7 downto 0);-- := (others => '0');
   signal B : std_logic_vector(7 downto 0);-- := (others => '0');

 	--Outputs
   signal S : std_logic_vector(7 downto 0);
   signal N : std_logic;
   signal O : std_logic;
   signal Z : std_logic;
   signal C : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          S => S,
          N => N,
          O => O,
          Z => Z,
          C => C,
          Ctrl_Alu => Ctrl_Alu,
          A => A,
          B => B
        );
        
           A <= x"A0", x"A0" after 10 ns, x"03" after 20 ns, x"FF" after 30 ns, x"FF" after 40 ns;
           B <= x"0A", x"0A" after 10 ns, x"0A" after 20 ns, x"04" after 30 ns, x"04" after 40 ns;
    Ctrl_Alu <= "001", "010" after 10 ns, "010" after 20 ns, "100" after 30 ns, "011" after 40 ns;
END;
