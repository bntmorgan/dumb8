----------------------------------------------------------------------------------
-- Company:        INSA de Toulouse
-- Engineer:       Morgan Beno�t
--                 Sauvanaud Carla
-- Create Date:    08:25:09 05/16/2012 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name:   Projet systemes informatiques
--                 du compilateur vers le microprocesseur
-- Target Devices: 
-- Tool versions: 
-- Description:    Unit� arithm�tique et logique de notre microprocesseur
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
begin
	with Ctrl_Alu select		
        sortie <= x"0000" or (a + b) when "001",
                  x"0000" or (a - b) when "010",
                  a * b when "011",
                  --a / b when "100",
                  x"0000" or (a + b) when others;
                  --faire les d�calages et la division
	
  -- Affectation de l'overflow
	with Ctrl_Alu select
				-- Cas d'une addition	
        O <= (a(7) and b(7) and not(sortie(7))) 
                   or (not(a(7)) and not(b(7)) and sortie(7)) when "001" ,
                   --Cas de la multiplication
                   sortie(15) or sortie(14) or sortie(13) or sortie(12) 
                   or sortie(11) or sortie(10) or sortie (9) or sortie (8) when "011",
                   --Cas de la soustraction (voir table de v�rit�...)
                   (not(a(7)) and b(7) and sortie(7)) 
                   or (a(7) and not(b(7)) and not(sortie(7)))when "010",
                   '0' when others;
		
  C <= sortie(8);
	N <= sortie(7);	
	Z <= '1' when sortie = x"00" else '0';
	S <= sortie(7 downto 0);
	
	
end Behavioral;
