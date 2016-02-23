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

entity memoire_instructions is
Port ( Adr : in  STD_LOGIC_VECTOR (7 downto 0);
       CLK : in STD_LOGIC;
       en : in STD_LOGIC; 
       DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end memoire_instructions;

architecture Behavioral of memoire_instructions is
  type memory_array is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
  --Memoire des instruction supposée ROM
  signal memoire : memory_array := (
                                    -- Test ALEAS
                                    -- Affectation de R0 avec x"02"
--                                    x"06",x"00",x"01",x"00",
--                                    x"06",x"01",x"02",x"00",
--                                    x"01",x"00",x"01",x"00",
--                                    x"08",x"00",x"00",x"00",
--                                    x"07",x"01",x"00",x"00",

                                      x"06",x"00",x"00",x"00",
                                      x"06",x"01",x"10",x"00",
                                      x"06",x"02",x"01",x"00",

                                      x"01",x"00",x"00",x"02",
                                      x"02",x"03",x"01",x"00",
                                      x"0A",x"1C",x"03",x"00",
                                      x"09",x"0C",x"00",x"00",
                                      x"09",x"1C",x"00",x"00",
                                    others =>x"00");
begin
  process(CLK)--, en)
  begin
    if en = '1' then
      if CLK='1' then
        DOUT <= memoire(conv_integer("0" & Adr)) & memoire(conv_integer("0" & Adr)+1) 
                & memoire(conv_integer("0" & Adr)+2) & memoire(conv_integer("0" & Adr)+3);
       end if;
    end if;
  end process;
end Behavioral;
