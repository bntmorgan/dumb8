----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:32 05/26/2012 
-- Design Name: 
-- Module Name:    op_to_ctrl_alu - Behavioral 
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

entity op_to_ctrl_alu is
  Port ( Op       : in  STD_LOGIC_VECTOR (7 downto 0);
         Ctrl_Alu : out STD_LOGIC_VECTOR (2 downto 0));
end op_to_ctrl_alu;

architecture Behavioral of op_to_ctrl_alu is

begin
  with Op select
                -- ADD
    Ctrl_Alu <= "001" when x"01",
                -- S0U
                "010" when x"03",
                -- SHL
                "011" when x"02",
                -- SHR
                "100" when x"04",
                "000" when others;

end Behavioral;
