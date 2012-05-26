----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:16:57 05/24/2012 
-- Design Name: 
-- Module Name:    chemin_de_donnees - Behavioral 
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

entity chemin_de_donnees is
  port (CLK : in STD_LOGIC;
        RST : in STD_LOGIC);

end chemin_de_donnees;

architecture Behavioral of chemin_de_donnees is
  -- Composants
  component banc_registres Port ( Adr_A : in  STD_LOGIC_VECTOR (3 downto 0);
                                  Adr_B : in  STD_LOGIC_VECTOR (3 downto 0);
                                  Adr_W : in  STD_LOGIC_VECTOR (3 downto 0);
                                  W     : in  STD_LOGIC;
                                  DATA  : in  STD_LOGIC_VECTOR (7 downto 0);
                                  RST   : in  STD_LOGIC;
                                  CLK   : in STD_LOGIC;
                                  QA    : out STD_LOGIC_VECTOR (7 downto 0);
                                  QB    : out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component alu port ( S : out  STD_LOGIC_VECTOR (7 downto 0);
                       N : out  STD_LOGIC;
                       O : out  STD_LOGIC;
                       Z : out  STD_LOGIC;
                       C : out  STD_LOGIC;
                       Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
                       A : in  STD_LOGIC_VECTOR (7 downto 0);
                       B : in STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component memoire_instructions port ( Adr : in  STD_LOGIC_VECTOR (7 downto 0);
                                        CLK : in STD_LOGIC;
                                        DOUT : out STD_LOGIC_VECTOR (31 downto 0));
  end component;
  component pipeline port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
                            A      : in  STD_LOGIC_VECTOR (7 downto 0);
                            B      : in  STD_LOGIC_VECTOR (7 downto 0);
                            C      : in  STD_LOGIC_VECTOR (7 downto 0);
                            Op_out : out  STD_LOGIC_VECTOR (7 downto 0);
                            A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
                            B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
                            C_out  : out  STD_LOGIC_VECTOR (7 downto 0);
                            CLK    : in  STD_LOGIC;
                            RST    : in  STD_LOGIC);
  end component;
  component memoire_donnees port ( Adr : in  STD_LOGIC_VECTOR (7 downto 0);
                                   DIN  : in  STD_LOGIC_VECTOR (7 downto 0);
                                   RW  : in  STD_LOGIC;
                                   RST : in  STD_LOGIC;
                                   CLK : in STD_LOGIC;
                                   DOUT : out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component decode port ( Instr  : in STD_LOGIC_VECTOR (31 downto 0);
                          Op_out : out  STD_LOGIC_VECTOR (7 downto 0);
                          A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
                          B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
                          C_out  : out  STD_LOGIC_VECTOR (7 downto 0));
  end component;
  
  component rw_regitres port( op : IN  std_logic_vector(7 downto 0);
                              w  : OUT  std_logic);
  end component;
  component compteur port ( CLK, SENS, LOAD : in  STD_LOGIC;
                            RST : in  STD_LOGIC;
                            EN : in  STD_LOGIC;
                            Din : in  STD_LOGIC_VECTOR (7 downto 0);
			                      Dout : out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component mux_sortie_banc_registres port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
                                             B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
                                             QA     : in  STD_LOGIC_VECTOR (7 downto 0);
                                             mux_out: out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  -- Déclaration des signaux entrée et sortie du pipeline : plus propre
  type pipeline_in_out is record
    a_in : STD_LOGIC_VECTOR (7 downto 0);
    a_out : STD_LOGIC_VECTOR (7 downto 0);
    op_in : STD_LOGIC_VECTOR (7 downto 0);
    op_out : STD_LOGIC_VECTOR (7 downto 0);
    b_in : STD_LOGIC_VECTOR (7 downto 0);
    b_out : STD_LOGIC_VECTOR (7 downto 0);
    c_in : STD_LOGIC_VECTOR (7 downto 0);
    c_out : STD_LOGIC_VECTOR (7 downto 0);
  end record;
  
  -- Sorties et entrées des pipelines
  
  signal li_di_con : pipeline_in_out;
  signal di_ex_con : pipeline_in_out;
  signal ex_mem_con : pipeline_in_out;
  signal mem_re_con : pipeline_in_out;

  -- Sortie de la LC après le dernier pipeline
  signal W : STD_LOGIC;
  
  -- Signaux relatifs au compteur du pointeur d'instructions
  signal SENS : STD_LOGIC := '1';
  signal LOAD : STD_LOGIC := '0';
  signal EN : STD_LOGIC := '0';
  signal din_cpt : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  signal instruction_pointer : STD_LOGIC_VECTOR (7 downto 0) := x"00";
  
  -- Sorties du banc de registres
  signal QA : STD_LOGIC_VECTOR(7 downto 0);
  signal QB : STD_LOGIC_VECTOR(7 downto 0);
  
  --Sortie du multiplexeur situé après le banc de registres
  signal msbr_out : STD_LOGIC_VECTOR(7 downto 0);
  
  -- Instruction sortant de la mémoire d'instructions
  signal instruction : STD_LOGIC_VECTOR (31 downto 0);
  
  signal Op : STD_LOGIC_VECTOR (7 downto 0);
  signal A : STD_LOGIC_VECTOR (7 downto 0);
  signal B : STD_LOGIC_VECTOR (7 downto 0);
  signal C : STD_LOGIC_VECTOR (7 downto 0);
  
  signal Op_out : STD_LOGIC_VECTOR (7 downto 0);
  signal A_out : STD_LOGIC_VECTOR (7 downto 0);
  signal B_out : STD_LOGIC_VECTOR (7 downto 0);
  signal C_out : STD_LOGIC_VECTOR (7 downto 0);
  
begin
  -- Pipelines

  pLI_DI : pipeline port map ( li_di_con.a_in, 
                               li_di_con.op_in, 
                               li_di_con.b_in, 
                               li_di_con.c_in, 
                               li_di_con.a_out, 
                               li_di_con.op_out, 
                               li_di_con.b_out, 
                               li_di_con.c_out,
                               CLK,
                               RST);

  sipDI_EX : pipeline port map ( di_ex_con.a_in, 
                               di_ex_con.op_in, 
                               di_ex_con.b_in, 
                               di_ex_con.c_in, 
                               di_ex_con.a_out, 
                               di_ex_con.op_out, 
                               di_ex_con.b_out, 
                               di_ex_con.c_out,
                               CLK,
                               RST);

  pEX_Mem : pipeline port map ( ex_mem_con.a_in, 
                                ex_mem_con.op_in, 
                                ex_mem_con.b_in, 
                                ex_mem_con.c_in, 
                                ex_mem_con.a_out, 
                                ex_mem_con.op_out, 
                                ex_mem_con.b_out, 
                                ex_mem_con.c_out,
                                CLK,
                                RST);

  pMem_Re : pipeline port map ( mem_re_con.a_in, 
                                mem_re_con.op_in, 
                                mem_re_con.b_in, 
                                mem_re_con.c_in, 
                                mem_re_con.a_out, 
                                mem_re_con.op_out, 
                                mem_re_con.b_out, 
                                mem_re_con.c_out,
                                CLK,
                                RST);

  rw_r : rw_regitres port map (Op_out, W);
  
  -- Interconnexion des composants
  li_di_con.a_in <= A;
  li_di_con.op_in <= Op;
  li_di_con.b_in <= B;
  li_di_con.c_in <= C;
  
  di_ex_con.a_in <= li_di_con.a_out;
  di_ex_con.op_in <= li_di_con.op_out;
  di_ex_con.b_in <= msbr_out;
  di_ex_con.c_in <= QB;
 
  ex_mem_con.a_in <= di_ex_con.a_out;
  ex_mem_con.op_in <= di_ex_con.op_out;
  ex_mem_con.b_in <= di_ex_con.b_out;

  mem_re_con.a_in <= ex_mem_con.a_out;
  mem_re_con.op_in <= ex_mem_con.op_out;
  mem_re_con.op_in <= ex_mem_con.op_out;

  A_out <= mem_re_con.a_out;
  Op_out <= mem_re_con.op_out;
  B_out <= mem_re_con.b_out;
  C_out <= mem_re_con.c_out;

  -- Compteur incrémentant de 4 le Pointer Instruction
  ip : compteur port map (CLK, SENS, LOAD, RST, EN, din_cpt, instruction_pointer);
  mi : memoire_instructions port map (instruction_pointer, CLK, instruction);
  -- Decodeur d'instructions
  di : decode port map (instruction, A, Op, B, C);
  br : banc_registres port map (li_di_con.b_out(3 downto 0), li_di_con.c_out(3 downto 0), A_out(3 downto 0), W, B_out, RST, CLK, QA, QB);
  msbr : mux_sortie_banc_registres port map( li_di_con.op_out, li_di_con.b_out, QA, msbr_out);

end Behavioral;
