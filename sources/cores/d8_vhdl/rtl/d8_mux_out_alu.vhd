-- Copyright (C) 2012 Carla Sauvanaud
-- Copyright (C) 2012, 2016  BenoÃ®t Morgan
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

entity mux_out_alu is
  Port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
         B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
         S     : in  STD_LOGIC_VECTOR (7 downto 0);
         mux_out: out STD_LOGIC_VECTOR (7 downto 0));
end mux_out_alu;

architecture Behavioral of mux_out_alu is

begin
             -- Cas AFC et COP: la sortie B_out du pipeline di/ex
             -- est recopiée dans l'entrée B_in du ex/mem
  mux_out <= S when Op = x"01" or Op = x"02" or Op = x"03" or Op = x"04" else
             B_in;

end Behavioral;
