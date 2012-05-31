----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:20 05/25/2012 
-- Design Name: 
-- Module Name:    mux_out_br - Behavioral 
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

entity mux_out_br is
  Port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
         B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
         QA     : in  STD_LOGIC_VECTOR (7 downto 0);
         mux_out: out STD_LOGIC_VECTOR (7 downto 0));
end mux_out_br;

architecture Behavioral of mux_out_br is

begin
             -- Cas AFC et LOAD: la sortie B_out du pipeline li/di
             -- est recopiée dans l'entrée B_in du di/ex
  mux_out <= B_in when Op = x"06" or Op = x"07" else
             -- Cas COP, SHR, SHL, ADD, SOU, STORE : le pipeline di/ex reÃ§oit 
             -- la sortie de la lecture du banc de registres
             QA; 

end Behavioral;
