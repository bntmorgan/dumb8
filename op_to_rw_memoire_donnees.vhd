----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:26 05/26/2012 
-- Design Name: 
-- Module Name:    op_to_rw_memoire_donnees - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity op_to_rw_memoire_donnees is
    Port ( Op : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : out  STD_LOGIC);
end op_to_rw_memoire_donnees;

architecture Behavioral of op_to_rw_memoire_donnees is

begin

with Op select
	RW <= '0' when x"08",
			  '1' when others;

end Behavioral;

