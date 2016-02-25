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

entity alu is
    Port ( S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
           A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0));
end alu;

architecture Behavioral of alu is
  signal sortie : std_logic_vector(15 downto 0);
  signal zero   : std_logic_vector(7 downto 0);
  signal decale : std_logic_vector(31 downto 0);
begin
  -- Signal temporaire util lors des décalages
  zero <= x"00";
  decale <= x"0000" & A & x"00";
  sortie <= (x"00" & A) + (x"00" & B) when Ctrl_Alu = "001" else
            (x"00" & A) - (x"00" & B) when Ctrl_Alu = "010" else
             -- Multiplication super lente
             -- a * b when "011",
             
             -- Décalage à gauche
             --x"00" & A when Ctrl_Alu = "011" and B = x"00" else
             --x"00" & A(7 - conv_integer(B) downto 0) & zero(conv_integer(B)-1 downto 0) when Ctrl_Alu = "011" and B < "1000" else
             --decale(23 - conv_integer('0' & B) downto 8 - conv_integer('0' & B)) when Ctrl_Alu = "011" and B < "1000" else
             
             -- Décalage à droite
             --x"00" & A when Ctrl_Alu = "100" and B = x"00" else
             --x"00" & zero(conv_integer(B)-1 downto 0) & A(7 downto conv_integer(B)) when Ctrl_Alu = "100" and conv_integer(B) < 8 else
             --decale(23 + conv_integer('0' & B) downto 8 + conv_integer('0' & B)) when Ctrl_Alu = "100" and conv_integer(B) < 8 else
             
             -- x"00" dans le cas général
             (x"00" & A);
	
  -- Affectation de l'overflow
	with Ctrl_Alu select
				-- Cas d'une addition	
        O <= (A(7) and B(7) and not(sortie(7))) 
                   or (not(A(7)) and not(B(7)) and sortie(7)) when "001" ,
                   --Cas de la multiplication
                   sortie(15) or sortie(14) or sortie(13) or sortie(12) 
                   or sortie(11) or sortie(10) or sortie (9) or sortie (8) when "011",
                   --Cas de la soustraction (voir table de vérité...)
                   (not(A(7)) and B(7) and sortie(7)) 
                   or (A(7) and not(B(7)) and not(sortie(7)))when "010",
                   '0' when others;
		
  C <= sortie(8);
	N <= sortie(7);	
	Z <= '1' when sortie(7 downto 0) = x"00" else '0';
	S <= sortie(7 downto 0);
	
	
end Behavioral;
