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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_aleas_handler IS
END test_aleas_handler;

ARCHITECTURE behavior OF test_aleas_handler IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT aleas_handler
    PORT(
         di_ex_op : IN  STD_LOGIC_VECTOR (7 downto 0);
         di_ex_a : IN  STD_LOGIC_VECTOR (7 downto 0);
         ex_mem_op : IN  STD_LOGIC_VECTOR (7 downto 0);
         ex_mem_a : IN  STD_LOGIC_VECTOR (7 downto 0);
         mem_re_op : IN  STD_LOGIC_VECTOR (7 downto 0);
         mem_re_a : IN  STD_LOGIC_VECTOR (7 downto 0);
         li_di_op : IN  std_logic_vector(7 downto 0);
         li_di_b : IN  std_logic_vector(7 downto 0);
         li_di_c : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         clk_out : OUT  std_logic;
         li_di_op_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal di_ex_op : std_logic_vector(7 downto 0) := (others => '0');
   signal di_ex_a : std_logic_vector(7 downto 0) := (others => '0');
   signal ex_mem_op : std_logic_vector(7 downto 0) := (others => '0');
   signal ex_mem_a : std_logic_vector(7 downto 0) := (others => '0');
   signal mem_re_op : std_logic_vector(7 downto 0) := (others => '0');
   signal mem_re_a : std_logic_vector(7 downto 0) := (others => '0');
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
          di_ex_op => di_ex_op,
          di_ex_a => di_ex_a,
          li_di_op => li_di_op,
          li_di_b => li_di_b,
          li_di_c => li_di_c,
          clk => clk,
          clk_out => clk_out,
          li_di_op_out => li_di_op_out
        );

	clk <= not clk after CLK_period/2;

	di_ex_a <= x"00", x"00" after 10 ns, x"00" after 20 ns, x"00" after 30 ns;
	di_ex_op <= x"06", x"06" after 10 ns, x"06" after 20 ns, x"00" after 30 ns;
	li_di_b <= x"00", x"00" after 10 ns, x"01" after 20 ns, x"00" after 30 ns;
	li_di_c <= x"00", x"00" after 10 ns, x"00" after 20 ns, x"00" after 30 ns;
	li_di_op <= x"05", x"01" after 10 ns, x"05" after 20 ns, x"00" after 30 ns;

END;
