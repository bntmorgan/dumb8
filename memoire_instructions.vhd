----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:26:09 05/17/2012 
-- Design Name: 
-- Module Name:    memoire_instructions - Behavioral 
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

entity memoire_instructions is
Port ( Adr : in  STD_LOGIC_VECTOR (7 downto 0);
       CLK : in STD_LOGIC;
       DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end memoire_instructions;

architecture Behavioral of memoire_instructions is
  type memory_array is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
  --Memoire des instruction supposée ROM
  signal memoire : memory_array := (
                                    -- Test ALEAS
                                    -- Affectation de R0 avec x"02"
                                    x"06",x"00",x"02",x"00",
                                    -- Copie de R0 dans R1
                                    x"05",x"01",x"00",x"00",
                                    
                                    -- Affectation de R0 avec x"02"
                                    x"06",x"00",x"02",x"00",
                                    -- NOP
                                    x"00",x"00",x"00",x"00",
                                    -- Copie de R0 dans R1
                                    x"05",x"01",x"00",x"00",
                                    
                                    -- Affectation de R0 avec x"02"
                                    x"06",x"00",x"02",x"00",
                                    -- NOP
                                    x"00",x"00",x"00",x"00",
                                    -- NOP
                                    x"00",x"00",x"00",x"00",
                                    -- Copie de R0 dans R1
                                    x"05",x"01",x"00",x"00",

                                    -- Affectation de R0 avec x"02"
                                    x"06",x"00",x"02",x"00",
                                    -- Affectation de R1 avec x"05"
                                    x"06",x"01",x"05",x"00",
                                    -- Affectation de R2 avec x"05"
                                    x"06",x"02",x"05",x"00",
                                    -- Affectation de R3 avec x"03"
                                    x"06",x"03",x"03",x"00",
                                    -- Affectation de R4 avec x"D4"
                                    x"06",x"04",x"D4",x"00",
                                    -- Affectation de R5 avec x"FF"
                                    x"06",x"05",x"EF",x"00",
                                    -- Affectation de R6 avec x"EF"
                                    x"06",x"06",x"EF",x"00",
                                    -- Affectation de R7 avec x"EF"
                                    x"06",x"07",x"EF",x"00",
                                    -- Affectation de R8 avec x"FF"
                                    x"06",x"08",x"FF",x"00",                                   
                                    
                                    -- Addition de R1 et R2 mise dans R9
                                    x"01",x"09",x"01",x"02",
                                    -- Soustraction de R1 et R2 dans R9
                                    x"03",x"09",x"01",x"02",
                                    -- Décalage droite de R7 de 5(dans R1) dans R10
                                    x"04",x"0A",x"07",x"01",
                                    -- Décalage gauche de R7 de 2(dans R0) dans R11
                                    x"02",x"0B",x"07",x"00",
                                    -- Décalage gauche de R7 de 0(dans R9) dans R12
                                    x"02",x"0C",x"07",x"09",
                                    -- Décalage gauche de R7 de FF(dans R8) dans R12
                                    x"02",x"0C",x"07",x"08",
                                    
                                    -- Copie de R1 dans R9
                                    x"05",x"09",x"00",x"00",
                                    -- Copie de R8 dans R9
                                    x"05",x"02",x"00",x"00",
															 
                                    -- Chargement de R1 avec [R1]
                                    x"07",x"01",x"01",x"00",
                                    -- Sauvegarde de R2 Dans [R0]
                                    x"08",x"00",x"03",x"00",
                                    others =>x"00");
begin
  process(CLK)
  begin
    if CLK'event and CLK='1' then
      DOUT <= memoire(conv_integer("0" & Adr)) & memoire(conv_integer("0" & Adr)+1) 
              & memoire(conv_integer("0" & Adr)+2) & memoire(conv_integer("0" & Adr)+3);
    end if;
  end process;
end Behavioral;
