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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY test_compteur IS
END test_compteur;

ARCHITECTURE behavior OF test_compteur IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT compteur
    PORT(
         CLK : IN  std_logic;
         SENS : IN  std_logic;
         LOAD : IN  std_logic;
         RST : IN  std_logic;
         EN : IN  std_logic;
         Din : IN  std_logic_vector(7 downto 0);
         Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal CLK : std_logic := '0';
   signal SENS : std_logic := '0';
   signal LOAD : std_logic := '0';
   signal RST : std_logic := '0';
   signal EN : std_logic := '0';
   signal Din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: compteur PORT MAP (
          CLK => CLK,
          SENS => SENS,
          LOAD => LOAD,
          RST => RST,
          EN => EN,
          Din => Din,
          Dout => Dout
        );

	CLK <= not CLK after CLK_period/2;
	
	RST <= '0', '1' after 30ns, '0' after 300 ns, '1' after 320 ns;
	LOAD <= '0', '1' after 120ns, '0' after 150ns;
	DIN <= x"AB", x"01" after 190ns;
	EN <= '0', '1' after 200ns, '0' after 235ns;
	SENS <= '1', '0' after 250ns, '1' after 400ns;
	
END;
