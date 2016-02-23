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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:20 05/25/2012 
-- Design Name: 
-- Module Name:    mux_out_br - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_out_br is
  Port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
         B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
         QA     : in  STD_LOGIC_VECTOR (7 downto 0);
         mux_out: out STD_LOGIC_VECTOR (7 downto 0));
end mux_out_br;

architecture Behavioral of mux_out_br is

begin
             -- Cas AFC et LOAD: la sortie B_out du pipeline li/di
             -- est recopiée dans l'entrée B_in du di/ex
  mux_out <= B_in when Op = x"06" or Op = x"07" else
             -- Cas COP, SHR, SHL, ADD, SOU, STORE : le pipeline di/ex reÃ§oit 
             -- la sortie de la lecture du banc de registres
             QA; 

end Behavioral;
