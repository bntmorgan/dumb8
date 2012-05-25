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
  process(CLK)
  begin
    -- RST actif à '0' et synchrone avec l'horloge
    if CLK'event and CLK='0' then
      if RST = '0' then 
        registres <= (others => x"00");
        QA <= x"00";
        QB <= x"00";
      else
        -- Dans tous les cas on écrit en sortie
        QA <= registres(conv_integer("0" & Adr_A));
        QB <= registres(conv_integer("0" & Adr_B));
        -- Cas de l'aléa : écriture et lecture simultanees
        if W='1' and Adr_A = Adr_W then
          registres(conv_integer("0" & Adr_W)) <= DATA;
          QA <= DATA;
        else 
          -- Cas de l'aléa
          if W='1' and Adr_B = Adr_W then
            registres(conv_integer("0" & Adr_W)) <= DATA;
            QB <= DATA;
          else
            -- Cas général d'écriture dans un registre
            if W='1' then
              registres(conv_integer("0" & Adr_W)) <= DATA;
            else
              -- TODO : que faire dans ce cas là ?
              QA <= x"00";
              QB <= x"00";
            end if;
          end if;          
        end if;
      end if;
    end if;
    

  end process;
end Behavioral;
