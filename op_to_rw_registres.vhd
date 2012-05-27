----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:01:08 05/24/2012 
-- Design Name: 
-- Module Name:    op_to_rw_registres - Behavioral 
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

entity op_to_rw_registres is
  port (
    op : in STD_LOGIC_VECTOR(7 downto 0);
    w : out STD_LOGIC
  );
end op_to_rw_registres;

architecture Behavioral of op_to_rw_registres is

begin

  with op select
       -- Ecriture dans les cas suivants
       -- AFC
  w <= '1' when x"05",
       -- COP
       '1' when x"06",
       -- ADD
       '1' when x"01",
       -- SHL
       '1' when x"02",
       -- SOU
       '1' when x"03",
       -- SHR
       '1' when x"04",
       -- LOAD
       '1' when x"07",
       '0' when others;

end Behavioral;
