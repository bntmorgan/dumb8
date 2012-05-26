----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:20 05/25/2012 
-- Design Name: 
-- Module Name:    mux_out_alu - Behavioral 
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

entity mux_out_alu is
  Port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
         B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
         S     : in  STD_LOGIC_VECTOR (7 downto 0);
         mux_out: out STD_LOGIC_VECTOR (7 downto 0));
end mux_out_alu;

architecture Behavioral of mux_out_alu is

begin
             -- Cas AFC et COP: la sortie B_out du pipeline di/ex
             -- est recopiée dans l'entrée B_in du ex/mem
  mux_out <= B_in when Op = x"06" or Op = x"05" else
             -- Cas SHR, SHL, ADD, SOU
             S when Op = x"01" or Op = x"02" or Op = x"03" or Op = x"04" else
             B_in;

end Behavioral;
