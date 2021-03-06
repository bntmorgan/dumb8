-- Copyright (C) 2012 Carla Sauvanaud
-- Copyright (C) 2012, 2016  Benoît Morgan
--
-- This file is part of dumb8.
--
-- dumb8 is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- dumb8 is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with dumb8.  If not, see <http://www.gnu.org/licenses/>.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity d8_top is
  port (CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        LED : out STD_LOGIC_VECTOR(7 downto 0));

end d8_top;

architecture Behavioral of d8_top is
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
                                        en : in STD_LOGIC;
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
                            en     : in STD_LOGIC;
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
  component op_to_rw_registres port( op : IN  std_logic_vector(7 downto 0);
                              w  : OUT  std_logic);
  end component;
  component compteur port ( CLK, SENS, LOAD : in  STD_LOGIC;
                            RST : in  STD_LOGIC;
                            EN : in  STD_LOGIC;
                            Din : in  STD_LOGIC_VECTOR (7 downto 0);
			                      Dout : out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component mux_out_br port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
                              B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
                              QA     : in  STD_LOGIC_VECTOR (7 downto 0);
                              mux_out: out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component op_to_ctrl_alu port ( Op       : in  STD_LOGIC_VECTOR (7 downto 0);
                                  Ctrl_Alu : out STD_LOGIC_VECTOR (2 downto 0));
  end component;
  component mux_out_alu port ( Op     : in  STD_LOGIC_VECTOR (7 downto 0);
                               B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
                               S      : in  STD_LOGIC_VECTOR (7 downto 0);
                               mux_out: out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component op_to_rw_memoire_donnees port ( Op : in  STD_LOGIC_VECTOR (7 downto 0);
                                            RW : out  STD_LOGIC);
  end component;
  component mux_out_memoire_donnees port ( DOUT  : in  STD_LOGIC_VECTOR (7 downto 0);
                                           B_IN  : in  STD_LOGIC_VECTOR (7 downto 0);
                                           Op    : in  STD_LOGIC_VECTOR (7 downto 0);
                                           B_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component mux_in_memoire_donnees port ( A   : in  STD_LOGIC_VECTOR (7 downto 0);
                                          Op  : in  STD_LOGIC_VECTOR (7 downto 0);
                                          B   : in  STD_LOGIC_VECTOR (7 downto 0);
                                          Adr : out  STD_LOGIC_VECTOR (7 downto 0));
  end component;
  component aleas_handler port ( di_ex_op     : in  STD_LOGIC_VECTOR (7 downto 0);
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
  end component;
  component jmp_handler port ( Op      : in  STD_LOGIC_VECTOR (7 downto 0);
                               A       : in  STD_LOGIC_VECTOR (7 downto 0);
                               Z       : in  STD_LOGIC;
                               RST     : out STD_LOGIC;
                               mem_adr : out STD_LOGIC_VECTOR (7 downto 0);
                               LOAD    : out STD_LOGIC);
  end component;
  
  -- Déclaration des signaux entrée et sortie du pipeline : plus propre
  type pipeline_in_out is record
    op_in : STD_LOGIC_VECTOR (7 downto 0);
    op_out : STD_LOGIC_VECTOR (7 downto 0);
    a_in : STD_LOGIC_VECTOR (7 downto 0);
    a_out : STD_LOGIC_VECTOR (7 downto 0);
    b_in : STD_LOGIC_VECTOR (7 downto 0);
    b_out : STD_LOGIC_VECTOR (7 downto 0);
    c_in : STD_LOGIC_VECTOR (7 downto 0);
    c_out : STD_LOGIC_VECTOR (7 downto 0);
  end record;
  
  type alu_in_out is record
    s : STD_LOGIC_VECTOR (7 downto 0);
    n : STD_LOGIC;
    o : STD_LOGIC;
    z : STD_LOGIC;
    c : STD_LOGIC;
    ctrl_alu : STD_LOGIC_VECTOR (2 downto 0);
    a : STD_LOGIC_VECTOR (7 downto 0);
    b : STD_LOGIC_VECTOR (7 downto 0);
  end record;

  type memoire_donnees_in_out is record 
    adr : STD_LOGIC_VECTOR(7 downto 0);
    din : STD_LOGIC_VECTOR(7 downto 0);
    rw : STD_LOGIC;
    rst : STD_LOGIC;
    clk : STD_LOGIC;
    dout : STD_LOGIC_VECTOR(7 downto 0);
  end record;

  type aleas_handler_in_out is record
    di_ex_op : STD_LOGIC_VECTOR (7 downto 0);
    di_ex_a : STD_LOGIC_VECTOR (7 downto 0);
    ex_mem_op : STD_LOGIC_VECTOR (7 downto 0);
    ex_mem_a : STD_LOGIC_VECTOR (7 downto 0);
    li_di_op : STD_LOGIC_VECTOR (7 downto 0);
    li_di_a : STD_LOGIC_VECTOR (7 downto 0);
    li_di_b : STD_LOGIC_VECTOR (7 downto 0);
    li_di_c : STD_LOGIC_VECTOR (7 downto 0);
    clk : STD_LOGIC;
    en : STD_LOGIC;
    li_di_op_out : STD_LOGIC_VECTOR (7 downto 0);
  end record;
    
  type jmp_handler_in_out is record  
    rst     : STD_LOGIC;
    mem_adr : STD_LOGIC_VECTOR (7 downto 0);
    load    : STD_LOGIC;
  end record;
  -- Entrées et sorties des pipelines
  
  signal li_di_con : pipeline_in_out;
  signal di_ex_con : pipeline_in_out;
  signal ex_mem_con : pipeline_in_out;
  signal mem_re_con : pipeline_in_out;

  -- Entrées et sorties de l'alu
  signal alu_con : alu_in_out;

  -- Entrées et sorties de la mémoire de données
  signal md_con : memoire_donnees_in_out;

  -- Entrées et sorties du handler d'aleas
  signal ah_con : aleas_handler_in_out;

  signal jh_con : jmp_handler_in_out;

  -- Sortie de la LC après le dernier pipeline
  signal W : STD_LOGIC;
  
  -- Signaux relatifs au compteur du pointeur d'instructions
  signal SENS : STD_LOGIC := '1';
  signal EN : STD_LOGIC := '0';
  signal din_cpt : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  signal instruction_pointer : STD_LOGIC_VECTOR (7 downto 0) := x"00";
  
  -- Sorties du banc de registres
  signal QA : STD_LOGIC_VECTOR(7 downto 0);
  signal QB : STD_LOGIC_VECTOR(7 downto 0);
  
  -- Sortie du multiplexeur situé après le banc de registres
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
  
  signal rst_li_di : STD_LOGIC;
  
begin
  rst_li_di <= RST and jh_con.rst;

  -- Pipelines
  pLI_DI : pipeline port map ( li_di_con.op_in, 
                               li_di_con.a_in, 
                               li_di_con.b_in, 
                               li_di_con.c_in, 
                               li_di_con.op_out, 
                               li_di_con.a_out, 
                               li_di_con.b_out, 
                               li_di_con.c_out,
                               CLK,
                               ah_con.en,
                               rst_li_di);

  sipDI_EX : pipeline port map ( di_ex_con.op_in, 
                                 di_ex_con.a_in, 
                                 di_ex_con.b_in, 
                                 di_ex_con.c_in, 
                                 di_ex_con.op_out, 
                                 di_ex_con.a_out, 
                                 di_ex_con.b_out, 
                                 di_ex_con.c_out,
                                 CLK,
                                 '1',
                                 RST);

  pEX_Mem : pipeline port map ( ex_mem_con.op_in, 
                                ex_mem_con.a_in, 
                                ex_mem_con.b_in, 
                                ex_mem_con.c_in, 
                                ex_mem_con.op_out, 
                                ex_mem_con.a_out, 
                                ex_mem_con.b_out, 
                                ex_mem_con.c_out,
                                CLK,
                                '1',
                                RST);

  pMem_Re : pipeline port map ( mem_re_con.op_in, 
                                mem_re_con.a_in, 
                                mem_re_con.b_in, 
                                mem_re_con.c_in, 
                                mem_re_con.op_out, 
                                mem_re_con.a_out, 
                                mem_re_con.b_out, 
                                mem_re_con.c_out,
                                CLK,
                                '1',
                                RST);

  rw_r : op_to_rw_registres port map (Op_out, W);

  otca : op_to_ctrl_alu port map (di_ex_con.op_out, alu_con.ctrl_alu);
 
  al : alu port map ( alu_con.s, 
                      alu_con.n, 
                      alu_con.o, 
                      alu_con.z, 
                      alu_con.c, 
                      alu_con.ctrl_alu, 
                      alu_con.a, 
                      alu_con.b);
 
  moa : mux_out_alu port map ( di_ex_con.op_out,
                               di_ex_con.b_out,
                               alu_con.s,
                               ex_mem_con.b_in);
  
  md : memoire_donnees port map ( md_con.adr,
                                  md_con.din,
                                  md_con.rw,
                                  md_con.rst,
                                  md_con.clk,
                                  md_con.dout);

  otrmd : op_to_rw_memoire_donnees port map ( ex_mem_con.op_out,
                                              md_con.rw);

  momd : mux_out_memoire_donnees port map ( md_con.dout,
                                            ex_mem_con.b_out,
                                            ex_mem_con.op_out,
                                            mem_re_con.b_in);

  mimd : mux_in_memoire_donnees port map ( ex_mem_con.a_out, 
                                           ex_mem_con.op_out,
                                           ex_mem_con.b_out,
                                           md_con.adr);

  ah : aleas_handler port map ( ah_con.di_ex_op,
                                ah_con.di_ex_a,
                                ah_con.ex_mem_op,
                                ah_con.ex_mem_a,
                                ah_con.li_di_op,
                                ah_con.li_di_a,
                                ah_con.li_di_b,
                                ah_con.li_di_c,
                                ah_con.clk,
                                ah_con.en,
                                ah_con.li_di_op_out);

  -- Interconnexion des composants
  li_di_con.op_in <= Op;
  li_di_con.a_in <= A;
  li_di_con.b_in <= B;
  li_di_con.c_in <= C;
  
  di_ex_con.op_in <= ah_con.li_di_op_out;
  di_ex_con.a_in <= li_di_con.a_out;
  di_ex_con.b_in <= msbr_out;
  di_ex_con.c_in <= QB;
  alu_con.a <= di_ex_con.b_out;
  alu_con.b <= di_ex_con.c_out;
 
  ex_mem_con.op_in <= di_ex_con.op_out;
  ex_mem_con.a_in <= di_ex_con.a_out;

  mem_re_con.op_in <= ex_mem_con.op_out;
  mem_re_con.a_in <= ex_mem_con.a_out;
  
  md_con.rst <= RST;
  md_con.clk <= CLK;
  md_con.din <= ex_mem_con.b_out;

  Op_out <= mem_re_con.op_out;
  A_out <= mem_re_con.a_out;
  B_out <= mem_re_con.b_out;
  C_out <= mem_re_con.c_out;

  ah_con.clk <= CLK;
  ah_con.di_ex_op <= di_ex_con.op_out;
  ah_con.di_ex_a <= di_ex_con.a_out;
  ah_con.ex_mem_op <= ex_mem_con.op_out;
  ah_con.ex_mem_a <= ex_mem_con.a_out;
  ah_con.li_di_op <= li_di_con.op_out;
  ah_con.li_di_a <= li_di_con.a_out;
  ah_con.li_di_b <= li_di_con.b_out;
  ah_con.li_di_c <= li_di_con.c_out;

  -- Compteur incrémentant de 4 le Pointer Instruction
  ip : compteur port map (CLK, SENS, jh_con.load, RST, ah_con.en, jh_con.mem_adr, instruction_pointer);
  mi : memoire_instructions port map (instruction_pointer, CLK, ah_con.en, instruction);
  -- Decodeur d'instructions
  di : decode port map (instruction, Op, A, B, C);
  br : banc_registres port map (li_di_con.b_out(3 downto 0), li_di_con.c_out(3 downto 0), A_out(3 downto 0), W, B_out, RST, CLK, QA, QB);
  msbr : mux_out_br port map(li_di_con.op_out, li_di_con.b_out, QA, msbr_out);

  jh : jmp_handler port map( di_ex_con.op_out, di_ex_con.a_out, alu_con.z, jh_con.rst, jh_con.mem_adr, jh_con.load);

  LED <= alu_con.s;

end Behavioral;
