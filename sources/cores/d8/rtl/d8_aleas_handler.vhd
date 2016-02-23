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

entity aleas_handler is
    Port ( di_ex_op     : in  STD_LOGIC_VECTOR (7 downto 0);
           di_ex_a      : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_op    : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_a     : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_op     : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_a      : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_b      : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_c      : in  STD_LOGIC_VECTOR (7 downto 0);
           clk          : in  STD_LOGIC;
           en           : out  STD_LOGIC;
           li_di_op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end aleas_handler;

architecture Behavioral of aleas_handler is

signal len : STD_LOGIC;
signal wait_one : STD_LOGIC;

begin

en <= len;

len <= 
  '0' when (((((((ex_mem_a = li_di_b) or (ex_mem_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (ex_mem_a = li_di_b and (li_di_op = x"05" or li_di_op = x"08" or li_di_op = x"0A" or li_di_op = x"09"))) and 
      (ex_mem_op = x"01" or ex_mem_op = x"02" or ex_mem_op = x"03" or ex_mem_op = x"04" or ex_mem_op = x"05" or ex_mem_op = x"06" or ex_mem_op = x"07")) or 
    (((((di_ex_a = li_di_b) or (di_ex_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (di_ex_a = li_di_b and (li_di_op = x"05" or li_di_op = x"08" or li_di_op = x"0A" or li_di_op = x"09"))) and 
      (di_ex_op = x"01" or di_ex_op = x"02" or di_ex_op = x"03" or di_ex_op = x"04" or di_ex_op = x"05" or di_ex_op = x"06" or di_ex_op = x"07")))) else 
  '1';

li_di_op_out <=
  x"00" when len = '0' else
  li_di_op;

end Behavioral;
