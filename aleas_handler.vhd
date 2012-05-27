----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:12 05/27/2012 
-- Design Name: 
-- Module Name:    aleas_handler - Behavioral 
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

entity aleas_handler is
    Port ( op_in : in  STD_LOGIC_VECTOR (7 downto 0);
           a_in : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_op : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_b : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_c : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           clk_out : out  STD_LOGIC;
           li_di_op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end aleas_handler;

architecture Behavioral of aleas_handler is

begin

clk_out <= '0' when 
  ((((a_in = li_di_b) or (a_in = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
     (a_in = li_di_b and (li_di_op = x"05" or li_di_op = x"08"))) and 
     (op_in = x"01" or op_in = x"02" or op_in = x"03" or op_in = x"04" or op_in = x"05" or op_in = x"06" or op_in = x"07") else clk;

li_di_op_out <= x"00" when 
  ((((a_in = li_di_b) or (a_in = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
     (a_in = li_di_b and (li_di_op = x"05" or li_di_op = x"08"))) and 
     (op_in = x"01" or op_in = x"02" or op_in = x"03" or op_in = x"04" or op_in = x"05" or op_in = x"06" or op_in = x"07") else li_di_op;

end Behavioral;

