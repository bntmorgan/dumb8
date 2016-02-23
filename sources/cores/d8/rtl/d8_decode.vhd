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

entity decode is
 port ( Instr  : in   STD_LOGIC_VECTOR (31 downto 0);
        Op_out : out  STD_LOGIC_VECTOR (7 downto 0);
        A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
        B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
        C_out  : out  STD_LOGIC_VECTOR (7 downto 0));
end decode;

architecture Behavioral of decode is

begin
  Op_out <= Instr(31 downto 24);
  A_out  <= Instr(23 downto 16);
  B_out  <= Instr(15 downto 8);
  C_out  <= Instr(7 downto 0);
end Behavioral;
