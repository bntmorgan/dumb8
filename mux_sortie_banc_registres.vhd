----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:20 05/25/2012 
-- Design Name: 
-- Module Name:    mux_sortie_banc_registres - Behavioral 
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

entity mux_sortie_banc_registres is
  Port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
         B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
         QA     : in  STD_LOGIC_VECTOR (7 downto 0);
         mux_out: out STD_LOGIC_VECTOR (7 downto 0));
end mux_sortie_banc_registres;

architecture Behavioral of mux_sortie_banc_registres is

begin
  with Op select
             -- Cas AFC : la sortie B_out du pipeline li/di
             -- est recopiée dans l'entrée B_in du di/ex
  mux_out <= B_in when x"06" ,
             -- Cas COP : le pipeline di/ex reçoit 
             -- la sortie de la lecture du banc de registres
             QA when x"05" ,
             B_in when others;

end Behavioral;
