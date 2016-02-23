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

ENTITY test_rw_registres IS
END test_rw_registres;

ARCHITECTURE behavior OF test_rw_registres IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT rw_regitres
    PORT(
         op : IN  std_logic_vector(7 downto 0);
         w : OUT  std_logic
        );
    END COMPONENT;


   --Inputs
   signal op : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal w : std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: rw_regitres PORT MAP (
          op => op,
          w => w
        );

   -- No clocks detected in port list. Replace <clock> below with
   -- appropriate port name

  op <= x"00", x"06" after 10 ns, x"00" after 20 ns;

END;
