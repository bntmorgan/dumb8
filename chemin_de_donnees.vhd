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

  -- Sorties et entrées des pipelines
  signal Op : STD_LOGIC_VECTOR (7 downto 0);
  signal A : STD_LOGIC_VECTOR (7 downto 0);
  signal B : STD_LOGIC_VECTOR (7 downto 0);
  signal C : STD_LOGIC_VECTOR (7 downto 0);
  
  signal Op_LI_DI_DI_EX : STD_LOGIC_VECTOR (7 downto 0);
  signal A_LI_DI_DI_EX : STD_LOGIC_VECTOR (7 downto 0);
  signal B_LI_DI_DI_EX : STD_LOGIC_VECTOR (7 downto 0);
  signal C_LI_DI_DI_EX : STD_LOGIC_VECTOR (7 downto 0);
  
  signal Op_DI_EX_EX_Mem : STD_LOGIC_VECTOR (7 downto 0);
  signal A_DI_EX_EX_Mem : STD_LOGIC_VECTOR (7 downto 0);
  signal B_DI_EX_EX_Mem : STD_LOGIC_VECTOR (7 downto 0);
  signal C_DI_EX_EX_Mem : STD_LOGIC_VECTOR (7 downto 0);
  
  signal Op_EX_Mem_Mem_RE : STD_LOGIC_VECTOR (7 downto 0);
  signal A_EX_Mem_Mem_RE : STD_LOGIC_VECTOR (7 downto 0);
  signal B_EX_Mem_Mem_RE : STD_LOGIC_VECTOR (7 downto 0);
  signal C_EX_Mem_Mem_RE : STD_LOGIC_VECTOR (7 downto 0);
  
  signal Op_out : STD_LOGIC_VECTOR (7 downto 0);
  signal A_out : STD_LOGIC_VECTOR (7 downto 0);
  signal B_out : STD_LOGIC_VECTOR (7 downto 0);
  signal C_out : STD_LOGIC_VECTOR (7 downto 0);
  
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
  
  signal tuning : STD_LOGIC_VECTOR(7 downto 0):= x"00";
  
begin
  -- Compteur incrémentant de 4 le Pointer Instruction
  ip : compteur port map (CLK, SENS, LOAD, RST, EN, din_cpt, instruction_pointer);
  mi : memoire_instructions port map (instruction_pointer, CLK, instruction);
  -- Decodeur d'instructions
  di : decode port map (instruction, Op, A, B, C);
  br : banc_registres port map (B_LI_DI_DI_EX(3 downto 0), C_LI_DI_DI_EX(3 downto 0), A_out(3 downto 0), W, B_out, RST, CLK, QA, QB);
  msbr : mux_sortie_banc_registres port map( Op_LI_DI_DI_EX, B_LI_DI_DI_EX, QA, msbr_out);
  
  pLI_DI : pipeline port map (Op, A, B, C, Op_LI_DI_DI_EX, A_LI_DI_DI_EX, B_LI_DI_DI_EX, C_LI_DI_DI_EX, CLK, RST);
  pDI_EX : pipeline port map (Op_LI_DI_DI_EX, A_LI_DI_DI_EX, msbr_out, C_LI_DI_DI_EX, Op_DI_EX_EX_Mem, A_DI_EX_EX_Mem, B_DI_EX_EX_Mem, C_DI_EX_EX_Mem, CLK, RST);
  pEX_Mem : pipeline port map (Op_DI_EX_EX_Mem, A_DI_EX_EX_Mem, B_DI_EX_EX_Mem, C_DI_EX_EX_Mem, Op_EX_Mem_Mem_RE, A_EX_Mem_Mem_RE, B_EX_Mem_Mem_RE, C_EX_Mem_Mem_RE, CLK, RST);
  pMem_RE : pipeline port map (Op_EX_Mem_Mem_RE, A_EX_Mem_Mem_RE, B_EX_Mem_Mem_RE, C_EX_Mem_Mem_RE, Op_out, A_out, B_out, C_out, CLK, RST);
  
  rw_r : rw_regitres port map (Op_out, W);
  
end Behavioral;
