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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity op_to_rw_registres is
  port (
    op : in STD_LOGIC_VECTOR(7 downto 0);
    w : out STD_LOGIC
  );
end op_to_rw_registres;

architecture Behavioral of op_to_rw_registres is

begin

  with op select
       -- Ecriture dans les cas suivants
       -- AFC
  w <= '1' when x"05",
       -- COP
       '1' when x"06",
       -- ADD
       '1' when x"01",
       -- SHL
       '1' when x"02",
       -- SOU
       '1' when x"03",
       -- SHR
       '1' when x"04",
       -- LOAD
       '1' when x"07",
       '0' when others;

end Behavioral;
