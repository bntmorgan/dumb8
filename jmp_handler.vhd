----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:45 06/03/2012 
-- Design Name: 
-- Module Name:    jmp_handler - Behavioral 
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

entity jmp_handler is port (
         Op      : in  STD_LOGIC_VECTOR (7 downto 0);
         A       : in  STD_LOGIC_VECTOR (7 downto 0);
         Z       : in  STD_LOGIC;
         RST     : out STD_LOGIC;
         mem_adr : out STD_LOGIC_VECTOR (7 downto 0);
         LOAD    : out STD_LOGIC);
end jmp_handler;

architecture Behavioral of jmp_handler is

begin

  RST <= '0' when (Op = x"0A" and Z='1') or Op = x"09" else '1';
  mem_adr <= A when (Op = x"0A" and Z='1') or Op = x"09" else x"00";
  LOAD <= '1' when (Op = x"0A" and Z='1') or Op = x"09" else '0';

end Behavioral;

