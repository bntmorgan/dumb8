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
-- Company:        INSA de Toulouse
-- Engineer:       Morgan Benoît
--                 Sauvanaud Carla
-- Create Date:    05/17/2012 
-- Design Name: 
-- Module Name:    banc_registres - Behavioral 
-- Project Name:   Projet systemes informatiques
--                 du compilateur vers le microprocesseur
-- Target Devices: 
-- Tool versions: 
-- Description:    Banc de registres double port de lecture de notre microprocesseur
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

entity banc_registres is
  Port ( Adr_A : in  STD_LOGIC_VECTOR (3 downto 0);
         Adr_B : in  STD_LOGIC_VECTOR (3 downto 0);
         Adr_W : in  STD_LOGIC_VECTOR (3 downto 0);
         W     : in  STD_LOGIC;
         DATA  : in  STD_LOGIC_VECTOR (7 downto 0);
         RST   : in  STD_LOGIC;
         CLK   : in STD_LOGIC;
         QA    : out STD_LOGIC_VECTOR (7 downto 0);
         QB    : out STD_LOGIC_VECTOR (7 downto 0));
end banc_registres;

architecture Behavioral of banc_registres is
  type register_array is array (0 to 15) of STD_LOGIC_VECTOR (7 downto 0);
  -- Valeurs initiales pour le debug
  signal registres : register_array := (others => x"00");
                                    
begin
  
  QA <= x"00" when RST = '0' else
        DATA when W = '1' and Adr_A = Adr_W else 
        registres(conv_integer("0" & Adr_A));

  QB <= x"00" when RST = '0' else
        DATA when W = '1' and Adr_B = Adr_W else 
        registres(conv_integer("0" & Adr_B));
  
  process(CLK)
  begin
    -- RST actif à '0' et synchrone avec l'horloge
    if CLK'event and CLK='1' then
      if RST = '0' then 
        registres <= (others => x"00");
      else
        -- Cas général d'écriture dans un registre
        if W='1' then
          registres(conv_integer("0" & Adr_W)) <= DATA;
        end if;
      end if;
    end if;
  end process;

end Behavioral;
