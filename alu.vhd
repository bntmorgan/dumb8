----------------------------------------------------------------------------------
-- Company:        INSA de Toulouse
-- Engineer:       Morgan Benoît
--                 Sauvanaud Carla
-- Create Date:    08:25:09 05/16/2012 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name:   Projet systemes informatiques
--                 du compilateur vers le microprocesseur
-- Target Devices: 
-- Tool versions: 
-- Description:    Unité arithmétique et logique de notre microprocesseur
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
begin
  -- Signal temporaire util lors des décalages
  zero <= x"00";

  sortie <= (x"00" & a) + (x"00" & b) when Ctrl_Alu = "001" else
            (x"00" & a) - (x"00" & b) when Ctrl_Alu = "010" else
             -- Multiplication super lente
             -- a * b when "011",
             -- Décalage à gauche
             x"00" & a when Ctrl_Alu = "011" and B = x"00" else
             x"00" & a(7 - conv_integer(b) downto 0) & zero(conv_integer(b)-1 downto 0) when Ctrl_Alu = "011" and conv_integer(b) < 8 else
             -- Décalage à droite
             x"00" & a when Ctrl_Alu = "100" and B = x"00" else
             x"00" & zero(conv_integer(b)-1 downto 0) & a(7 downto conv_integer(b)) when Ctrl_Alu = "100" and conv_integer(b) < 8 else
             -- x"00" dans le cas général
             (x"00" & x"00");
	
  -- Affectation de l'overflow
	with Ctrl_Alu select
				-- Cas d'une addition	
        O <= (a(7) and b(7) and not(sortie(7))) 
                   or (not(a(7)) and not(b(7)) and sortie(7)) when "001" ,
                   --Cas de la multiplication
                   sortie(15) or sortie(14) or sortie(13) or sortie(12) 
                   or sortie(11) or sortie(10) or sortie (9) or sortie (8) when "011",
                   --Cas de la soustraction (voir table de vérité...)
                   (not(a(7)) and b(7) and sortie(7)) 
                   or (a(7) and not(b(7)) and not(sortie(7)))when "010",
                   '0' when others;
		
  C <= sortie(8);
	N <= sortie(7);	
	Z <= '1' when sortie(7 downto 0) = x"00" else '0';
	S <= sortie(7 downto 0);
	
	
end Behavioral;
