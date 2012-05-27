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
                                    x"06",x"00",x"01",x"00",
                                    x"06",x"01",x"02",x"00",
                                    x"01",x"00",x"01",x"00",
                                    x"08",x"00",x"00",x"00",
                                    x"07",x"01",x"00",x"00",
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
