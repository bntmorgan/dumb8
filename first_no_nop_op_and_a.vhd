----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:52:40 05/27/2012 
-- Design Name: 
-- Module Name:    first_no_nop_op_and_a - Behavioral 
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

entity first_no_nop_op_and_a is
    Port ( di_ex_a : in  STD_LOGIC_VECTOR (7 downto 0);
           di_ex_op : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_a : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_op : in  STD_LOGIC_VECTOR (7 downto 0);
           mem_re_a : in  STD_LOGIC_VECTOR (7 downto 0);
           mem_re_op : in  STD_LOGIC_VECTOR (7 downto 0);
           a_out : out  STD_LOGIC_VECTOR (7 downto 0);
           op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end first_no_nop_op_and_a;

architecture Behavioral of first_no_nop_op_and_a is

begin

op_out <= di_ex_op when di_ex_op /= x"00" else
          ex_mem_op when ex_mem_op /= x"00" else
          mem_re_op when mem_re_op /= x"00" else
          x"00";

a_out <= di_ex_a when di_ex_op /= x"00" else
         ex_mem_a when ex_mem_op /= x"00" else
         mem_re_a when mem_re_op /= x"00" else
         x"00";

end Behavioral;

