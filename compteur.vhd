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

	process (RST ,CLK, EN)
	begin
	if RST ='0' then cpt <= X"00" ; -- rst asynchrone : a cause du bouton
	else		
		if CLK='1' then
			if LOAD = '1' then
				cpt <= Din;
			else
				if EN = '1' then
					if SENS = '1' then cpt <= cpt + 4; end if;
					if SENS = '0' then cpt <= cpt - 4; end if;
				end if;
			end if ;
		end if ;
	end if;
	
	end process;	
	Dout <= cpt;	
	
	
	
end Behavioral;
