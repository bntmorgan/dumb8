----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:26:09 05/17/2012 
-- Design Name: 
-- Module Name:    memoire_donnees - Behavioral 
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
  process(CLK)
  begin
    if CLK'event and CLK='1' then
      if RST = '0' then
        memoire <= (others => x"00");
        DOUT <= x"00";
      else
        -- Ecriture lorsque RW = '0'
        if RW='0' then
          memoire(conv_integer("0" & Adr)) <= DIN;
        else
          -- Cas de lecture de la memoire
          DOUT <= memoire(conv_integer("0" & Adr));
        end if;
      end if;
    end if;
  
  end process;
end Behavioral;
