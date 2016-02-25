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

entity op_to_ctrl_alu is
  Port ( Op       : in  STD_LOGIC_VECTOR (7 downto 0);
         Ctrl_Alu : out STD_LOGIC_VECTOR (2 downto 0));
end op_to_ctrl_alu;

architecture Behavioral of op_to_ctrl_alu is

begin
  with Op select
                -- ADD
    Ctrl_Alu <= "001" when x"01",
                -- S0U
                "010" when x"02",
                -- SHL
                "011" when x"03",
                -- SHR
                "100" when x"04",
                "000" when others;

end Behavioral;
