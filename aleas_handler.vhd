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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aleas_handler is
    Port ( di_ex_op     : in  STD_LOGIC_VECTOR (7 downto 0);
           di_ex_a      : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_op    : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_a     : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_op     : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_a      : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_b      : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_c      : in  STD_LOGIC_VECTOR (7 downto 0);
           clk          : in  STD_LOGIC;
           en           : out  STD_LOGIC;
           li_di_op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end aleas_handler;

architecture Behavioral of aleas_handler is

signal len : STD_LOGIC;
signal wait_one : STD_LOGIC;

begin

en <= len;

len <= 
  '0' when (((((((ex_mem_a = li_di_b) or (ex_mem_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (ex_mem_a = li_di_b and (li_di_op = x"05" or li_di_op = x"08" or li_di_op = x"0A" or li_di_op = x"09"))) and 
      (ex_mem_op = x"01" or ex_mem_op = x"02" or ex_mem_op = x"03" or ex_mem_op = x"04" or ex_mem_op = x"05" or ex_mem_op = x"06" or ex_mem_op = x"07")) or 
    (((((di_ex_a = li_di_b) or (di_ex_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (di_ex_a = li_di_b and (li_di_op = x"05" or li_di_op = x"08" or li_di_op = x"0A" or li_di_op = x"09"))) and 
      (di_ex_op = x"01" or di_ex_op = x"02" or di_ex_op = x"03" or di_ex_op = x"04" or di_ex_op = x"05" or di_ex_op = x"06" or di_ex_op = x"07")))) else 
  '1';

li_di_op_out <=
  x"00" when len = '0' else
  li_di_op;

end Behavioral;



