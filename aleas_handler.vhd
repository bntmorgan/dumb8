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
    Port ( di_ex_op : in  STD_LOGIC_VECTOR (7 downto 0);
           di_ex_a : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_op : in  STD_LOGIC_VECTOR (7 downto 0);
           ex_mem_a : in  STD_LOGIC_VECTOR (7 downto 0);
           mem_re_op : in  STD_LOGIC_VECTOR (7 downto 0);
           mem_re_a : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_op : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_a : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_b : in  STD_LOGIC_VECTOR (7 downto 0);
           li_di_c : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           clk_out : out  STD_LOGIC;
           li_di_op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end aleas_handler;

architecture Behavioral of aleas_handler is

signal wait_one : STD_LOGIC := '0';

begin

clk_out <= 
  '0' when ((((((mem_re_a = li_di_b) or (mem_re_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (mem_re_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (mem_re_a = li_di_a and li_di_op = x"08")) and 
      (mem_re_op = x"01" or mem_re_op = x"02" or mem_re_op = x"03" or mem_re_op = x"04" or mem_re_op = x"05" or mem_re_op = x"06" or mem_re_op = x"07")) or
    (((((ex_mem_a = li_di_b) or (ex_mem_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (ex_mem_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (ex_mem_a = li_di_a and li_di_op = x"08")) and 
      (ex_mem_op = x"01" or ex_mem_op = x"02" or ex_mem_op = x"03" or ex_mem_op = x"04" or ex_mem_op = x"05" or ex_mem_op = x"06" or ex_mem_op = x"07")) or 
    (((((di_ex_a = li_di_b) or (di_ex_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (di_ex_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (di_ex_a = li_di_a and li_di_op = x"08")) and 
      (di_ex_op = x"01" or di_ex_op = x"02" or di_ex_op = x"03" or di_ex_op = x"04" or di_ex_op = x"05" or di_ex_op = x"06" or di_ex_op = x"07"))) or wait_one /= '0' else 
  clk;

-- On doit attendre un coup d'horloge une fois l'alea terminé pour recopier l'instruction courante du pipeline
wait_one <= 
  '1' when ((((((mem_re_a = li_di_b) or (mem_re_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (mem_re_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (mem_re_a = li_di_a and li_di_op = x"08")) and 
      (mem_re_op = x"01" or mem_re_op = x"02" or mem_re_op = x"03" or mem_re_op = x"04" or mem_re_op = x"05" or mem_re_op = x"06" or mem_re_op = x"07")) or
    (((((ex_mem_a = li_di_b) or (ex_mem_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (ex_mem_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (ex_mem_a = li_di_a and li_di_op = x"08")) and 
      (ex_mem_op = x"01" or ex_mem_op = x"02" or ex_mem_op = x"03" or ex_mem_op = x"04" or ex_mem_op = x"05" or ex_mem_op = x"06" or ex_mem_op = x"07")) or 
    (((((di_ex_a = li_di_b) or (di_ex_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (di_ex_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (di_ex_a = li_di_a and li_di_op = x"08")) and 
      (di_ex_op = x"01" or di_ex_op = x"02" or di_ex_op = x"03" or di_ex_op = x"04" or di_ex_op = x"05" or di_ex_op = x"06" or di_ex_op = x"07"))) and rising_edge(clk) else
  '0' when wait_one = '1' and rising_edge(clk);
                 

li_di_op_out <=
  x"00" when ((((((mem_re_a = li_di_b) or (mem_re_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (mem_re_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (mem_re_a = li_di_a and li_di_op = x"08")) and 
      (mem_re_op = x"01" or mem_re_op = x"02" or mem_re_op = x"03" or mem_re_op = x"04" or mem_re_op = x"05" or mem_re_op = x"06" or mem_re_op = x"07")) or
    (((((ex_mem_a = li_di_b) or (ex_mem_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (ex_mem_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (ex_mem_a = li_di_a and li_di_op = x"08")) and 
      (ex_mem_op = x"01" or ex_mem_op = x"02" or ex_mem_op = x"03" or ex_mem_op = x"04" or ex_mem_op = x"05" or ex_mem_op = x"06" or ex_mem_op = x"07")) or 
    (((((di_ex_a = li_di_b) or (di_ex_a = li_di_c)) and (li_di_op = x"01" or li_di_op = x"02" or li_di_op = x"03" or li_di_op = x"04")) or 
      (di_ex_a = li_di_b and (li_di_op = x"05"  or li_di_op = x"07" or li_di_op = x"08")) or
      (di_ex_a = li_di_a and li_di_op = x"08")) and 
      (di_ex_op = x"01" or di_ex_op = x"02" or di_ex_op = x"03" or di_ex_op = x"04" or di_ex_op = x"05" or di_ex_op = x"06" or di_ex_op = x"07"))) else
  li_di_op;

end Behavioral;



