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

entity memoire_donnees is
Port ( Adr : in  STD_LOGIC_VECTOR (7 downto 0);
       DIN : in  STD_LOGIC_VECTOR (7 downto 0);
       RW  : in  STD_LOGIC;
       RST : in  STD_LOGIC;
       CLK : in STD_LOGIC;
       DOUT: out STD_LOGIC_VECTOR (7 downto 0));
end memoire_donnees;

architecture Behavioral of memoire_donnees is
  type memory_array is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
  signal memoire : memory_array := (others => x"00");
begin
  -- Cas de lecture de la memoire
  DOUT <= x"00" when RST = '0' else 
          memoire(conv_integer("0" & Adr)) when RW = '1';

  process(CLK)
  begin
    if CLK'event and CLK='1' then
      if RST = '0' then
        memoire <= (others => x"00");
      else
        -- Ecriture lorsque RW = '0'
        if RW = '0' then
          memoire(conv_integer("0" & Adr)) <= DIN;
        end if;
      end if;
    end if;

  end process;
end Behavioral;
