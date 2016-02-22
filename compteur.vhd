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

----------------------------------------------------------------------------------
-- Company: INSA
-- Engineer: Morgan et Sauvanaud
-- 
-- Create Date:    17:27:59 04/04/2012 
-- Design Name: 
-- Module Name:    compteur - Behavioral 
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

entity compteur is
    Port ( CLK, SENS, LOAD : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
			     Dout : out STD_LOGIC_VECTOR (7 downto 0));
end compteur;

architecture Behavioral of compteur is
signal cpt: STD_LOGIC_VECTOR(7 downto 0);
begin

	process (clk)
	begin
	if rst = '0' then
		cpt <= x"00";
	elsif en = '1' and clk = '1' then
		if LOAD = '1' then
			cpt <= Din;
		else
			if SENS = '1' then
				cpt <= cpt + 4;
			else
				cpt <= cpt - 4;
			end if;
		end if;
	end if;
	
	end process;	
	Dout <= cpt;	
	
end Behavioral;
