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
-- Company: 
-- Engineer:       Morgan Benoit
--                 Sauvanaud Carla
-- 
-- Create Date:    22:28:48 05/22/2012 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:    Pipeline du chemin de donnes de notre microprocesseur
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

entity pipeline is
  Port ( Op      : in  STD_LOGIC_VECTOR (7 downto 0);
         A       : in  STD_LOGIC_VECTOR (7 downto 0);
         B       : in  STD_LOGIC_VECTOR (7 downto 0);
         C       : in  STD_LOGIC_VECTOR (7 downto 0);
         Op_out  : out  STD_LOGIC_VECTOR (7 downto 0);
         A_out   : out  STD_LOGIC_VECTOR (7 downto 0);
         B_out   : out  STD_LOGIC_VECTOR (7 downto 0);
         C_out   : out  STD_LOGIC_VECTOR (7 downto 0);
         CLK     : in  STD_LOGIC;
         en      : in  STD_LOGIC;
         RST     : in  STD_LOGIC);
end pipeline;

architecture Behavioral of pipeline is

begin


    
  process(CLK)
    begin
      if RST='0' then
          Op_out <= x"00";
          A_out <= x"00";
          B_out <= x"00";
          C_out <= x"00";
      else 
        if en='1' then
          if CLK='1' then
            -- Copie des entres en sortie
            Op_out <= Op;
            A_out <= A;
            B_out <= B;
            C_out <= C;
          end if;
        end if;
      end if;
  end process;

end Behavioral;

