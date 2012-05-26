----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:35:59 05/24/2012 
-- Design Name: 
-- Module Name:    decode - Behavioral 
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

entity decode is
 port ( Instr  : in   STD_LOGIC_VECTOR (31 downto 0);
        Op_out : out  STD_LOGIC_VECTOR (7 downto 0);
        A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
        B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
        C_out  : out  STD_LOGIC_VECTOR (7 downto 0));
end decode;

architecture Behavioral of decode is

begin
  Op_out <= Instr(31 downto 24);
  A_out  <= Instr(23 downto 16);
  B_out  <= Instr(15 downto 8);
  C_out  <= Instr(7 downto 0);
end Behavioral;
