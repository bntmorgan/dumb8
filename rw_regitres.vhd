----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:01:08 05/24/2012 
-- Design Name: 
-- Module Name:    rw_regitres - Behavioral 
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

entity rw_regitres is
  port (
    op : in STD_LOGIC_VECTOR(7 downto 0);
    w : out STD_LOGIC
  );
end rw_regitres;

architecture Behavioral of rw_regitres is

begin
  with op select
       -- Ecriture dans les cas suivants
       -- AFC
  w <= '1' when x"06" ,
       -- COP
       '1' when x"05" ,
       '0' when others;

end Behavioral;
