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
